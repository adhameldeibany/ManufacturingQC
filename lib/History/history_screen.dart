import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:pds_manufacturing_version/Home/home_main.dart';
import 'package:pds_manufacturing_version/Information/phase_information.dart';
import 'package:pds_manufacturing_version/Models/HistoryModel.dart';
import 'package:pds_manufacturing_version/methods.dart';

List<HistoryModel> his = [];

var List11 = ['Phase','Code','Date'] ;
var List22 = [''];
String List1 = 'Phase';
String List2 = '';

class HistoryScreen extends StatefulWidget {
  HistoryScreen({List<HistoryModel>? history}){
    his.clear();
    his.addAll(history!);
  }

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}


class _HistoryScreenState extends State<HistoryScreen> {
  bool _isTap = false;
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

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
        iconTheme: IconThemeData(color: Colors.black,),
        title: Text('History', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
        ],
      ),
        body: Container(
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
              Expanded(
                child: ListView.builder(
                    itemCount: his.length,
                    itemBuilder: (context, index){
                      return Details(
                        child: his[index].TimeSubmitted,
                        child2: his[index].Phase,
                        child3: his[index].Barcode,
                        child4: his[index].Description,
                        child5: his[index].Accepted,
                        child6: his[index].Declined,
                        child8: his[index].Shift,
                      );
                    }
                ),
              ),
            ],
          ),
        )
    )
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
  final String child8;

  Details({required this.child, required this.child2, required this.child3, required this.child4, required this.child5, required this.child6, required this.child8});

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
                          Text("Phase: ",
                            style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                          SizedBox(
                            width: 160.w,
                            child: Text(widget.child2,
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
                                                  Get.off(HomeMain());
                                                  setState(() {
                                                    Navigator.pushReplacement(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (BuildContext context) => super.widget));
                                                  });
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
                              showDialog<void>(
                                context: context,
                                builder: (context){
                                  return Center(child: CircularProgressIndicator(
                                    color: mintgreen,
                                  ));
                                },
                              );
                              //Get.to(PhaseInformation());
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
                      //BarcodeLoadData("", "Phase", "", "", "", his, "", "");
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

