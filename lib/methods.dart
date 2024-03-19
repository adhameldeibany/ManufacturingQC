import 'dart:core';
import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:pds_manufacturing_version/History/history_screen.dart';
import 'package:pds_manufacturing_version/Home/home_main.dart';
import 'package:pds_manufacturing_version/Home/home_screen.dart';
import 'package:pds_manufacturing_version/Information/update_information.dart';
import 'package:pds_manufacturing_version/Models/HistoryModel.dart';
import 'package:pds_manufacturing_version/Profile/profile_screen.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';


final Color darkred = Color(0xff930000);
final Color lightblue = Color(0xff5573CD);
final Color mintgreen = Color(0xff19907C);
final Color redlight = Color(0xffEC1609);
final Color lightyellow = Color(0xffFEC107);


FirebaseDatabase database = FirebaseDatabase.instance;
FirebaseStorage storage = FirebaseStorage.instance;

Future<Widget> ProfileLoadData(int items, int acc, int rej, int reads) async{

  DatabaseReference ref = FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid.toString()}");
  DatabaseEvent event = await ref.once();
  return ProfileScreen(
      name: event.snapshot.child("name").value.toString(),
      picurl: event.snapshot.child("imageurl").value.toString(),
      id: event.snapshot.child("id").value.toString(),
      username: event.snapshot.child("username").value.toString(),
      accept: acc,
      items: items,
      reads: reads,
      reject: rej,
  );
}

Future<void> GetAllReads() async{
  int sumreads =0;
  int sumacc = 0;
  int sumrej = 0;
  int sumitems = 0;
  DatabaseReference ref = FirebaseDatabase.instance.ref("history/${FirebaseAuth.instance.currentUser?.uid.toString()}");
  await ref.onValue.listen((event) {
    for(final child in event.snapshot.children){
      sumacc += int.parse(child.child("approved").value.toString());
      sumrej += int.parse(child.child("declined").value.toString());
      sumitems += int.parse(child.child("total").value.toString());
      sumreads += 1;
    }
    ProfileLoadData(sumitems, sumacc, sumrej, sumreads);
  });

}

pickimage(ImageSource source) async{
  final ImagePicker imagePicker = ImagePicker();
  XFile? file = await imagePicker.pickImage(source: source);
  if (file != null) {
    Uint8List imgfile = await file.readAsBytes();
    saveData(file: imgfile);
    return imgfile;
  }
  print("No Images Selected");
}

Future<String> uploadImageToStorage(Uint8List file) async{
  Reference ref = storage.ref().child("images/"+FirebaseAuth.instance.currentUser!.uid.toString());
  UploadTask uploadTask = ref.putData(file);
  TaskSnapshot snapshot = await  uploadTask;
  String downloadurl = await snapshot.ref.getDownloadURL();
  return downloadurl;
}

Future<String> saveData({required Uint8List file}) async {
  String resp = "Some Error Occurred";
  try{
    String imageUrl = await uploadImageToStorage(file);
    DatabaseReference ref = FirebaseDatabase.instance.ref("users/${FirebaseAuth.instance.currentUser?.uid.toString()}");
    await ref.update({
      "imageurl": imageUrl,
    });
    resp = 'success';
  }catch(err){
    resp = err.toString();
  }
  return resp;
}

Future<void> BarcodeLoadData(String barcode, String target, String? selectedphase, String? Accepted, String? Rejected, String? olddate, String? shift, String? total) async {

  DatabaseReference ref = FirebaseDatabase.instance.ref("barcodes/$barcode/");
  DatabaseEvent event = await ref.once();
  GetPhases(barcode,event, target, selectedphase, Accepted,  olddate,  shift, Rejected,total);
}

Future<void> GetPhases(String barcode, DatabaseEvent ev, String target, String? selectedphase, String? Accepted, String? olddate, String? shift, String? Rejected,String? total) async{
  List<String> phases = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("phases/");
  await ref.onValue.listen((event) {
    for(final child in event.snapshot.children){
      phases.add(child.child("name").value.toString());
    }
    if(target == "Phase"){
      Get.off(UpdateInformation(
        Phases: phases,
        description: ev.snapshot.child("description").value.toString(),
        barcode: barcode,
        total: total,
        accepted: Accepted,
        Phase: selectedphase,
        rejected: Rejected,
        olddate: olddate,
        shift: shift,
      ));
    }
  });
}

Future<void> SubmitBarcode(String barcode, String description, String phase, String approved, String declined, String total) async{
  final currentTime = DateTime.now();
  final time = DateTime(currentTime.year,currentTime.month,currentTime.day,12,0,0,0,0);
  final currentDate = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour ,
      currentTime.minute,
      currentTime.second
  );
  DatabaseReference ref = FirebaseDatabase.instance.ref("history/${FirebaseAuth.instance.currentUser?.uid.toString()}/${currentDate.toString().replaceAll(':','-').replaceAll('.000','')}/");
  var shift = "صباحي";
  if (currentDate.isAfter(time)) {
    shift = "مسائي";
  }

  await ref.set({
    "barcode": barcode,
    "time": currentDate.toString().replaceAll(':','-').replaceAll('.000',''),
    "userid":FirebaseAuth.instance.currentUser?.uid.toString(),
    "approved":approved,
    "declined":declined,
    "description":description,
    "phase":phase,
    "shift": shift,
    "total":total
  });
  Get.off(HomeMain());
}

Future<void> GetHistory() async{
  List<HistoryModel> history = [];
  history.clear();
  DatabaseReference ref = FirebaseDatabase.instance.ref("history/${FirebaseAuth.instance.currentUser?.uid.toString()}/");
  await ref.onValue.listen((event) {
    for(final child in event.snapshot.children){
      HistoryModel historyModel = new HistoryModel(
          TimeSubmitted: child.child("time").value.toString(),
          Phase: child.child("phase").value.toString(),
          Barcode: child.child("barcode").value.toString(),
          Description: child.child("description").value.toString(),
          Accepted: child.child("approved").value.toString(),
          Declined: child.child("declined").value.toString(),
          Shift: child.child("shift").value.toString(),
          total: child.child("total").value.toString()
      );
      history.add(historyModel);
      print("===============================> " + historyModel.Phase);
    }
    HistoryScreen(
      history: history,
    );
  });


}

Future<void> EditAndLog(String? olddate,String? shift,String? phaseold,String? phasenew,String? barcode,String? description,
    String? Acceptedold,String? Acceptednew,String? rejectedold,String? rejectednew,String? State,String? total) async{
  final currentTime = DateTime.now();
  final time = DateTime(currentTime.year,currentTime.month,currentTime.day,12,0,0,0,0);
  final currentDate = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour ,
      currentTime.minute,
      currentTime.second
  );
  DatabaseReference ref = FirebaseDatabase.instance.ref("history/${FirebaseAuth.instance.currentUser?.uid.toString()}/${olddate}/");
  DatabaseReference ref2 = FirebaseDatabase.instance.ref("log/${FirebaseAuth.instance.currentUser?.uid.toString()}/${currentDate.toString().replaceAll(':','-').replaceAll('.000','')}/");

  await ref2.set({
    "barcode": barcode,
    "editedtime": currentDate.toString().replaceAll(':','-').replaceAll('.000',''),
    "oldtime": olddate,
    "userid":FirebaseAuth.instance.currentUser?.uid.toString(),
    "approved":Acceptedold,
    "declined":rejectedold,
    "description":description,
    "phase":phaseold,
    "shift": shift,
    "state": State,
    "total":total
  });

  await ref.set({
    "barcode": barcode,
    "time": olddate,
    "userid":FirebaseAuth.instance.currentUser?.uid.toString(),
    "approved":Acceptednew,
    "declined":rejectednew,
    "description":description,
    "phase":phasenew,
    "shift": shift,
    "total": total
  });
  Get.off(HomeMain());
}

Future<void> DeleteAndLog(String? olddate,String? shift,String? phaseold,String? barcode,String? description,String? Acceptedold,String? rejectedold,String? State) async{
  final currentTime = DateTime.now();
  final time = DateTime(currentTime.year,currentTime.month,currentTime.day,12,0,0,0,0);
  final currentDate = DateTime(
      currentTime.year,
      currentTime.month,
      currentTime.day,
      currentTime.hour ,
      currentTime.minute,
      currentTime.second
  );
  DatabaseReference ref = FirebaseDatabase.instance.ref("history/${FirebaseAuth.instance.currentUser?.uid.toString()}/${olddate}/");
  DatabaseReference ref2 = FirebaseDatabase.instance.ref("log/${FirebaseAuth.instance.currentUser?.uid.toString()}/${currentDate.toString().replaceAll(':','-').replaceAll('.000','')}/");
  await ref.remove();
  await ref2.set({
    "barcode": barcode,
    "editedtime": currentDate.toString().replaceAll(':','-').replaceAll('.000',''),
    "oldtime": olddate,
    "userid":FirebaseAuth.instance.currentUser?.uid.toString(),
    "approved":Acceptedold,
    "declined":rejectedold,
    "description":description,
    "phase":phaseold,
    "shift": shift,
    "state": State,
  });

}

Future<List<String>> GetPhasesOnly() async{
  List<String> phases = [];
  DatabaseReference ref = FirebaseDatabase.instance.ref("phases/");
  await ref.onValue.listen((event) {
    for(final child in event.snapshot.children){
      phases.add(child.child("name").value.toString());
    }
  });
  return phases;
}

Future<void> Edit() async{

}