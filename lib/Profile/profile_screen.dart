import 'dart:typed_data';
import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pds_manufacturing_version/methods.dart';
import 'package:image_picker/image_picker.dart';

String? Picurl, Id, Username, Name;
Uint8List? image;
int? it,acc,rej,red;
bool _isedit = false;

var List11 = ['Phase','Shift','Date'] ;
var List22 = [''];
String List1 = 'Phase';
String List2 = '';

class ProfileScreen extends StatefulWidget {

  ProfileScreen({String? picurl, String? id, String? username, String? name, int? items, int? accept, int? reject, int? reads}){
    Picurl = picurl;
    Id = id;
    Username = username;
    Name = name;
    it = items;
    red = reads;
    rej = reject;
    acc = accept;
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  DateTime dateTime = DateTime.now();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile', style: TextStyle(color: Colors.black),),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: [
        ],
      ),
        body: SingleChildScrollView(
          child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10),
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
                      padding: const EdgeInsets.all(5),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w,),
                          GestureDetector(
                            onTap:() async{
                              Uint8List img = await pickimage(ImageSource.gallery);
                              setState((){
                                image = img;
                              });
                            },
                            child: Container(
                              width: 70.w,
                              height: 110.h,
                              decoration: image != null?
                               BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: MemoryImage(image!),
                                )
                              ):
                              BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: (Picurl!.length == 0)? AssetImage('assets/p2.png'):Image.network(Picurl!.toString()).image
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    _isedit? TextFormField(
                                            decoration: InputDecoration(
                                            hintText: Name!,
                                            hintStyle: TextStyle(color: Colors.grey),
                                          ),
                                        )
                                        : Text(
                                      Name!,
                                      style: TextStyle(color: mintgreen, fontWeight: FontWeight.bold,fontSize: 16.sp),
                                    ),
                                    SizedBox(width: 25.w,),
                                    IconButton(onPressed: (){
                                      setState(() {
                                        _isedit = !_isedit;
                                      });
                                    }, icon: Icon(Icons.edit,color: Colors.black,))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Username: ',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    Text(
                                      Username!,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      'Id: ',
                                      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                    SizedBox(height: 40.h,),
                                    Expanded(
                                      child: Text(
                                        Id!,
                                        style: TextStyle(color: Colors.black),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 5.h,),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    width: double.infinity,
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
                    child: Column(
                      children: [
                        SizedBox(height: 15.h,),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              Text('States',
                                style: TextStyle(fontSize: 28.sp, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 20.h,),
                              Row(
                                children: [
                                  Text('Total reads: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.sp),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(red!.toString(),
                                      style: TextStyle(color: mintgreen, fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Text('Total accepted: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.sp),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(acc!.toString(),
                                      style: TextStyle(color: mintgreen, fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Text('Total rejected: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.sp),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(rej!.toString(),
                                      style: TextStyle(color: mintgreen, fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.h,),
                              Row(
                                children: [
                                  Text('Total item checked: ',
                                    style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black, fontSize: 18.sp),
                                  ),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: Text(it!.toString(),
                                      style: TextStyle(color: mintgreen, fontSize: 15.sp),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 25.h,),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
        ),
    );
  }
}