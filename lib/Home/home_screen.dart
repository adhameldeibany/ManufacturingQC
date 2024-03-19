import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pds_manufacturing_version/History/history_screen.dart';
import 'package:pds_manufacturing_version/Information/update_information.dart';
import 'package:pds_manufacturing_version/Manual%20Input/manual_input.dart';
import 'package:pds_manufacturing_version/Profile/profile_screen.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';
import 'package:pds_manufacturing_version/methods.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}
String result = '';

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      SizedBox(height: 100.h,),
                      InkWell(
                        onTap:() async {
                          var res = await
                          Get.to(SimpleBarcodeScannerPage());
                          setState(() {
                            if (res is String && res != "-1") {
                              showDialog<void>(
                                context: context,
                                builder: (context){
                                  return Center(child: CircularProgressIndicator(
                                    color: mintgreen,
                                  ));
                                },
                              );
                              result = res;
                              BarcodeLoadData(res,"Phase","","","","","","0");
                            }
                          });
                        },
                        child: Container(
                          height: 50.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                              color: mintgreen,
                              borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Scan",
                              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 50.h,),
                      InkWell(
                        onTap:() {
                          Get.to(ManualInput());
                        },
                        child: Container(
                          height: 50.h,
                          width: 250.w,
                          decoration: BoxDecoration(
                              color: mintgreen,
                              borderRadius: BorderRadius.circular(30),
                          ),
                          child: Center(
                            child: Text(
                              "Manual Input",
                              style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            SizedBox(height: 30.h,),
            Padding(
              padding: const EdgeInsets.only(left: 140),
              child: Image(
                image: AssetImage("assets/homelogo.png"),
                height: 230.h,
                width: 230.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
