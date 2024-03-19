import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pds_manufacturing_version/Information/phase_information.dart';
import 'package:pds_manufacturing_version/Models/HistoryModel.dart';
import 'package:pds_manufacturing_version/methods.dart';

List<String> selectedItems = [];
List<HistoryModel> sortedselectedItems = [];
DatabaseReference ref = FirebaseDatabase.instance.ref("history/${FirebaseAuth.instance.currentUser?.uid.toString()}/");
List<HistoryModel> his = [];
var List11 = ["Choose Filter",'Phase','Code','Date'] ;
var List22 = [''];
String List1 = "Choose Filter";
String List2 = '';
bool _isTap = false;
DateTime dateTime = DateTime.now();
List<String> phases = [];
List<String> codes = [];

class NewHistory extends StatefulWidget {
  const NewHistory({super.key});

  @override
  State<NewHistory> createState() => _NewHistoryState();
}

class _NewHistoryState extends State<NewHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black,),
        title: Text('History', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
        ],
      ),
      body: Container(
        child: StreamBuilder(
          stream: ref.onValue,
          builder: (context, snapshot) {
            phases.clear();
            DatabaseReference ref2 = FirebaseDatabase.instance.ref("phases/");
            ref2.onValue.listen((event) {
              for(final child in event.snapshot.children){
                phases.add(child.child("name").value.toString());
              }
            });
            codes.clear();
            DatabaseReference ref3 = FirebaseDatabase.instance.ref("barcodes/");
            ref3.onValue.listen((event) {
              for(final child in event.snapshot.children){
                codes.add(child.child("barcode").value.toString());
              }
            });
            List<HistoryModel> history = [];

            if (snapshot.hasData && snapshot.data != null && (snapshot.data! as DatabaseEvent).snapshot.value !=  null) {
              final histories = Map<dynamic, dynamic>.from(
                  (snapshot.data! as DatabaseEvent).snapshot.value as Map<dynamic, dynamic>); //typecasting
              histories.forEach((key, value) {
                final historyelement = Map<String, dynamic>.from(value);
                history.add(HistoryModel(
                    Accepted: historyelement['approved'],
                    Barcode: historyelement['barcode'],
                    Declined: historyelement['declined'],
                    Description: historyelement['description'],
                    Phase: historyelement['phase'],
                    Shift: historyelement['shift'],
                    TimeSubmitted: historyelement['time'],
                    total: historyelement['total']
                ));
              });
              his.addAll(history);

              var filterProducts = history.where((product) {
                return selectedItems.isEmpty ||
                    selectedItems.contains(product.Phase) || selectedItems.contains(product.Barcode) || selectedItems.contains(product.TimeSubmitted);
              }).toList();

              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 35.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1.w, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: DropdownButton<String>(
                                    underline: Container(color: Colors.white,),
                                    isExpanded: true,
                                    items: List11.map<DropdownMenuItem<String>>(
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
                                      List22.clear();
                                      if(alinanVeri! == "Date"){
                                        List22.add("Calendar");
                                        List2 = List22[0];
                                      }else if(alinanVeri! == "Phase"){
                                        List22.add("Choose Phase");
                                        for(String i in phases){
                                          if (List22.contains(i)) {

                                          }else{
                                            List22.add(i);
                                          }
                                        }
                                        List2 = List22[0];
                                      }else if(alinanVeri! == "Code"){
                                        List22.add("Choose Barcode");
                                        for(String i in codes){
                                          if (List22.contains(i)) {

                                          }else{
                                            List22.add(i);
                                          }
                                        }
                                        List2 = List22[0];
                                      }else if(alinanVeri! == "Choose Filter"){
                                        selectedItems.clear();
                                      }
                                      setState(() {
                                        List1 = alinanVeri!;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 35.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1.w, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: DropdownButton<String>(
                                    underline: Container(color: Colors.white,),
                                    isExpanded: true,
                                    items: List22.map<DropdownMenuItem<String>>(
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

                                    value: List2,
                                    onChanged:(alinanVeri)
                                    {
                                      setState(() {
                                        if(alinanVeri! == "Calendar"){
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) => SizedBox(
                                              height: 250.h,
                                              child: CupertinoDatePicker(
                                                backgroundColor: Colors.white,
                                                initialDateTime: dateTime,
                                                onDateTimeChanged: (DateTime newTime) {
                                                  setState(() {
                                                    dateTime = newTime;
                                                    selectedItems.clear();
                                                    bool existed = false;
                                                    history.forEach((item) {
                                                      String m = newTime.month.toString();
                                                      String d = newTime.day.toString();
                                                      if (newTime.month <10) {
                                                        m = "0"+m;
                                                      }
                                                      if (newTime.day <10) {
                                                        d = "0"+d;
                                                      }
                                                      if(item.TimeSubmitted.contains(newTime.year.toString() + "-" + m + "-" + d)){
                                                        existed = true;
                                                        selectedItems.add(item.TimeSubmitted);
                                                      }else{
                                                        existed = false;
                                                        selectedItems.add("محمد هشام");
                                                      }
                                                    });
                                                  });
                                                },
                                                use24hFormat: false,
                                                mode: CupertinoDatePickerMode.date,
                                              ),
                                            ),
                                          );
                                        }
                                        else if(List1 == "Phase"){
                                          selectedItems.clear();
                                          selectedItems.contains(alinanVeri!);
                                          selectedItems.add(alinanVeri!);
                                        }else if(List1 == "Code"){
                                          selectedItems.clear();
                                          selectedItems.contains(alinanVeri!);
                                          selectedItems.add(alinanVeri!);
                                        }
                                        List2 = alinanVeri!;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: filterProducts.length,
                          itemBuilder: (context, index){
                            final histoire = filterProducts[index];
                            return Details(
                              child: histoire.TimeSubmitted,
                              child2: histoire.Phase,
                              child3: histoire.Barcode,
                              child4: histoire.Description,
                              child5: histoire.Accepted,
                              child6: histoire.Declined,
                              child7: histoire.total,
                              child8: histoire.Shift,
                            );
                          }
                      ),
                    ),
                  ],
                ),
              );

            } else {
              return Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 12, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                              onPressed: (){
                                setState(() {
                                  _isTap =!_isTap;
                                });
                              },
                              icon: Icon(_isTap? FontAwesomeIcons.sortAmountDown: FontAwesomeIcons.sortAmountUp, color: _isTap?mintgreen : mintgreen, size: 30,)
                          ),
                          SizedBox(width: 12.w,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 35.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1.w, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: DropdownButton<String>(
                                    underline: Container(color: Colors.white,),
                                    isExpanded: true,
                                    items: List11.map<DropdownMenuItem<String>>(
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
                                        List22.clear();
                                        if(alinanVeri! == "Date"){
                                          List22.add("Calendar");
                                          List2 = List22[0];
                                        }
                                        List1 = alinanVeri!;
                                      });
                                    }),
                              ),
                            ),
                          ),
                          SizedBox(width: 10.w,),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              height: 35.h,
                              width: 120.w,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey, width: 1.w, ),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.only(left: 12, right: 12),
                                child: DropdownButton<String>(
                                    underline: Container(color: Colors.white,),
                                    isExpanded: true,
                                    items: List22.map<DropdownMenuItem<String>>(
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

                                    value: List2,
                                    onChanged:(alinanVeri)
                                    {
                                      setState(() {
                                        if(alinanVeri! == "Calendar"){
                                          showCupertinoModalPopup(
                                            context: context,
                                            builder: (BuildContext context) => SizedBox(
                                              height: 250.h,
                                              child: CupertinoDatePicker(
                                                backgroundColor: Colors.white,
                                                initialDateTime: dateTime,
                                                onDateTimeChanged: (DateTime newTime) {
                                                  // setState(() => dateTime = newTime);
                                                },
                                                use24hFormat: true,
                                                mode: CupertinoDatePickerMode.date,
                                              ),
                                            ),
                                          );
                                        }
                                        List2 = alinanVeri!;
                                      });
                                    }),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class Details extends StatefulWidget {

  final String child;
  final String child2;
  final String child3;
  final String child4;
  final String child5;
  final String child6;
  final String child7;
  final String child8;

  Details({required this.child, required this.child2, required this.child3, required this.child4, required this.child5, required this.child6, required this.child7, required this.child8});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10.h,),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      blurRadius: 10,
                      color: Colors.grey
                  ),
                ]
            ),
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Text("Name: ",
                            style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 160.w,
                            child: Text(widget.child8 + " - "+ widget.child2 + " - "+ widget.child7,
                              style: TextStyle(color: mintgreen, fontSize: 15.sp),),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.h,),
                      Row(
                        children: [
                          Text(widget.child,
                            textAlign: TextAlign.start,
                            style: TextStyle(color: mintgreen, fontSize: 15.sp, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: 20.h,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap:() {
                              showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Container(
                                      height: 230.h,
                                      width: 350.w,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text('Delete Phase', style: TextStyle(fontWeight: FontWeight.bold),),
                                          Icon(FontAwesomeIcons.warning, color: redlight, size: 45,),
                                          SizedBox(height: 10.h,),
                                          Text('This phase record will be permanently deleted!',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(fontWeight: FontWeight.bold),),
                                          SizedBox(height: 10.h,),
                                          Text('Are you sure you want to delete it?',
                                            textAlign: TextAlign.center,
                                          ),
                                          SizedBox(height: 10.h,),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                child: Container(
                                                  height: 30.h,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: redlight),
                                                    borderRadius: BorderRadius.circular(25),
                                                  ),
                                                  child: Center(child: Text('Cancel', style: TextStyle(color: redlight),)),
                                                ),
                                                onTap: () {
                                                  Navigator.pop(context);
                                                },
                                              ),
                                              InkWell(
                                                child: Container(
                                                  height: 30.h,
                                                  width: 100.w,
                                                  decoration: BoxDecoration(
                                                    color: redlight,
                                                    border: Border.all(color: redlight),
                                                    borderRadius: BorderRadius.circular(25),
                                                  ),
                                                  child: Center(child: Text('Delete', style: TextStyle(color: Colors.white),)),
                                                ),
                                                onTap: () {
                                                  showDialog<void>(
                                                    context: context,
                                                    builder: (context){
                                                      return Center(child: CircularProgressIndicator(
                                                        color: mintgreen,
                                                      ));
                                                    },
                                                  );
                                                  Navigator.pop(context);
                                                  Navigator.pop(context);
                                                  DeleteAndLog(widget.child, widget.child8, widget.child2, widget.child3, widget.child4, widget.child5, widget.child6, "Delete");
                                                },
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                            child: Center(
                              child: Text(
                                "Delete",
                                style: TextStyle(color: redlight, fontSize: 16.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          SizedBox(width: 60.w,),
                          InkWell(
                            onTap:() {
                              Get.to(PhaseInformation(HistoryModel(TimeSubmitted: widget.child, Phase: widget.child2, Barcode: widget.child3,
                                  Description: widget.child4, Accepted: widget.child5, Declined: widget.child6, Shift: widget.child8, total: widget.child7)));
                            },
                            child: Center(
                              child: Text(
                                "View",
                                style: TextStyle(color: mintgreen, fontSize: 16.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
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
                      BarcodeLoadData(widget.child3, "Phase", widget.child2, widget.child5, widget.child6, widget.child, widget.child8, widget.child7);
                      //           child: history[index].TimeSubmitted,
                      //           child2: history[index].Phase,
                      //           child3: history[index].Barcode,
                      //           child4: history[index].Description,
                      //           child5: history[index].Accepted,
                      //           child6: history[index].Declined,
                      //           child7: history[index].total,
                      //           child8: history[index].Shift,
                    },
                    child: Container(
                      height: 35.h,
                      width: 85.w,
                      decoration: BoxDecoration(
                        color: mintgreen,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Center(
                        child: Text(
                          "Edit",
                          style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}