import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pds_manufacturing_version/History/history_screen.dart';
import 'package:pds_manufacturing_version/Home/home_main.dart';
import 'package:pds_manufacturing_version/Home/home_screen.dart';
import 'package:pds_manufacturing_version/Information/update_information.dart';
import 'package:pds_manufacturing_version/Models/HistoryModel.dart';
import 'package:pds_manufacturing_version/methods.dart';

HistoryModel? historyModel;

class PhaseInformation extends StatefulWidget {
  PhaseInformation(HistoryModel? history){
     historyModel = history!;
  }

  @override
  State<PhaseInformation> createState() => _PhaseInformationState();
}

class _PhaseInformationState extends State<PhaseInformation> {


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
        backgroundColor: Colors.white,
        title: Text('Phase Information',
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20.sp),),
        centerTitle: true,
        leading: IconButton(
          onPressed: (){Get.off(HomeMain());},
          icon: Icon(Icons.arrow_back),
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 30, right: 20),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Phase: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text(historyModel!.Phase,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: mintgreen, fontSize: 16.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Code: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text(historyModel!.Barcode,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: mintgreen, fontSize: 16.sp),),
                      )
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Submission time: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Icon(Icons.calendar_today_sharp, color: mintgreen, size: 20,),
                      SizedBox(width: 3.w,),
                      Expanded(
                        child: Text(historyModel!.TimeSubmitted,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: mintgreen, fontSize: 16.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Shift : ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text(historyModel!.Shift,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: mintgreen, fontSize: 16.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Description: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text(historyModel!.Description,
                          textAlign: TextAlign.end,
                          style: TextStyle(color: mintgreen, fontSize: 16.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Accepted: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text(historyModel!.Accepted,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: mintgreen, fontSize: 16.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Rejected: ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Expanded(
                        child: Text(historyModel!.Declined,
                          textAlign: TextAlign.start,
                          style: TextStyle(color: mintgreen, fontSize: 16.sp),),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Total Checked : ',
                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.bold),),
                      Text(historyModel!.total,
                        style: TextStyle(color: mintgreen, fontSize: 16.sp),),
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
                    BarcodeLoadData(historyModel!.Barcode, "Phase", historyModel!.Phase, historyModel!.Accepted, historyModel!.Declined, historyModel!.TimeSubmitted, historyModel!.Shift, historyModel!.total);
                  },
                  child: Container(
                    height: 50.h,
                    width: 100.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: mintgreen)
                    ),
                    child: Center(
                      child: Text(
                        "Edit",
                        style: TextStyle(color: mintgreen, fontSize: 16.sp, fontWeight: FontWeight.bold),
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
                    Get.off(HomeMain());
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
                        "Done",
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
