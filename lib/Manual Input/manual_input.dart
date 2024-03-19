import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pds_manufacturing_version/Home/home_main.dart';
import 'package:pds_manufacturing_version/Home/home_screen.dart';
import 'package:pds_manufacturing_version/Information/update_information.dart';
import 'package:pds_manufacturing_version/methods.dart';

class ManualInput extends StatefulWidget {
  const ManualInput({Key? key}) : super(key: key);

  @override
  State<ManualInput> createState() => _ManualInputState();
}

class _ManualInputState extends State<ManualInput> {
  var List2 = <Icon>[Icon(Icons.search), Icon(Icons.file_copy)];
  Icon List3 = Icon(Icons.search);
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/home.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(Colors.black45, BlendMode.darken),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 210.h,
                width: 320.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey, width: 1.w, ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                          onPressed: (){Get.off(HomeMain());},
                          icon: Icon(Icons.arrow_back),
                          color: Colors.black,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: lightblue)
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 270.w,
                              height: 50.h,
                              child: TextFormField(
                                controller: controller,
                                decoration: InputDecoration(
                                  hintText: 'Enter Code',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 20.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {showDialog<void>(
                            context: context,
                            builder: (context){
                              return Center(child: CircularProgressIndicator(
                                color: mintgreen,
                              ));
                            },
                          );
                          BarcodeLoadData(controller.text.toString(),"Phase", "", "", "", "", "","0");
                          },
                          child: Container(
                            height: 40.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              color: mintgreen,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Text(
                                "Search",
                                style: TextStyle(color: Colors.white, fontSize: 18.sp, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

