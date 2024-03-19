import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pds_manufacturing_version/Home/home_main.dart';
import 'package:pds_manufacturing_version/Home/home_screen.dart';
import 'package:pds_manufacturing_version/methods.dart';

var Accepted = "0";
String? oldacc ;
bool _isedit = false;
var Declined = "0";
String? olddec ;
String? Barcode;
String? Description;
String? Total;
String? Olddate;
String? OldPhase;
String? Shift;
int t = 0;
List<String> phases = [];
TextEditingController controller1 = TextEditingController();
TextEditingController controller2 = TextEditingController();
String List1 = phases[0];

class UpdateInformation extends StatefulWidget {
  UpdateInformation({List<String>? Phases, String? barcode, String? description, String? total, String? accepted, String? rejected, String? Phase, String? olddate, String? shift }){
    t=0;
    phases.clear();
    phases.addAll(Phases!);
    Barcode = barcode;
    Description = description;
    t = int.parse(total!);
    oldacc = accepted!;
    olddec = rejected!;
    controller1.text = accepted!;
    controller2.text = rejected!;
    Olddate = olddate;
    OldPhase = Phase;
    Shift = shift;
    if (Phase != "") {
      List1 = Phase!;
      _isedit = true;
    }
  }

  @override
  State<UpdateInformation> createState() => _UpdateInformationState();
}

class _UpdateInformationState extends State<UpdateInformation> {



  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return WillPopScope(
        onWillPop: () {
      print('Backbutton pressed (device or appbar button), do whatever you want.');
      Get.off(HomeMain());
      //trigger leaving and use own data
      Navigator.pop(context, false);

      //we need to return a future
      return Future.value(false);
    },child: Scaffold(
      appBar: AppBar(
        backgroundColor: mintgreen,
        title: Text('Update Information',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20.sp),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){Get.off(HomeMain());},
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 30, right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Phase: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 40.h,
                          width: 200.w,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey, width: 1.w, ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: DropdownButton<String>(
                                underline: Container(color: Colors.white,),
                                isExpanded: true,
                                items: phases.map<DropdownMenuItem<String>>(
                                    (String value)
                                {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: SingleChildScrollView(
                                        scrollDirection: Axis.horizontal,
                                        child: Center(
                                            child: Text(value,
                                              style: TextStyle(color: mintgreen, fontSize: 15),))),
                                  );
                                }

                            ).toList(),
                                icon: Icon(Icons.arrow_drop_down),

                                value: List1,
                                onChanged:(alinanVeri)
                                {
                                  setState(() {
                                    List1 = alinanVeri!;
                                  });
                                }),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Barcode: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Text(Barcode!,
                        style: TextStyle(color: mintgreen, fontSize: 15.sp),)
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Description: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text(Description!,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: mintgreen, fontSize: 15.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Accepted: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Container(
                        height: 40.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: mintgreen, width: 1.w, ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 95.w,
                              height: 40.h,
                              child: TextFormField(
                                onChanged: (text){setState(() {
                                  int? c1,c2;
                                  if(controller1.text.length == 0){
                                    c1 = 0;
                                  }else{
                                    c1 = int.parse(controller1.text);
                                  }
                                  if(controller2.text.length == 0){
                                    c2 = 0;
                                  }else{
                                    c2 = int.parse(controller2.text);
                                  }
                                  t = c1 + c2;
                                });},
                                controller: controller1,
                                decoration: InputDecoration(
                                  hintText: '$Accepted',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    onPressed: controller1.clear,
                                    icon: Icon(Icons.clear, color: mintgreen,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Rejected: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Container(
                        height: 40.h,
                        width: 120.w,
                        decoration: BoxDecoration(
                          border: Border.all(color: mintgreen, width: 1.w, ),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 95.w,
                              height: 40.h,
                              child: TextFormField(
                                onChanged: (text){setState(() {
                                  int? c1,c2;
                                  if(controller1.text.length == 0){
                                    c1 = 0;
                                  }else{
                                    c1 = int.parse(controller1.text);
                                  }
                                  if(controller2.text.length == 0){
                                    c2 = 0;
                                  }else{
                                    c2 = int.parse(controller2.text);
                                  }
                                  t = c1 + c2;
                                });},
                                controller: controller2,
                                decoration: InputDecoration(
                                  hintText: '$Declined',
                                  hintStyle: TextStyle(color: Colors.grey),
                                  suffixIcon: IconButton(
                                    onPressed: controller2.clear,
                                    icon: Icon(Icons.clear, color: mintgreen,),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Total: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Text(t.toString(),
                        style: TextStyle(color: mintgreen, fontSize: 15.sp),),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 50.h,),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap:() {
                    showDialog<void>(
                      context: context,
                      builder: (context){
                        return Center(child: CircularProgressIndicator(
                          color: mintgreen,
                        ));
                      },
                    );
                    Get.off(HomeMain());
                  },
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: redlight,
                        borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 30.w,),
                InkWell(
                  onTap:() {
                    showDialog<void>(
                      context: context,
                      builder: (context){
                        return Center(child: CircularProgressIndicator(
                          color: mintgreen,
                        ));
                      },
                    );
                    _isedit?EditAndLog(Olddate, Shift, OldPhase, List1, Barcode, Description, oldacc, controller1.text, olddec, controller2.text, "Edit", t.toString()) : SubmitBarcode(Barcode!, Description!, List1, controller1.text.toString(), controller2.text.toString(),t.toString());
                  },
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      color: mintgreen,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    )
    );
  }
}
