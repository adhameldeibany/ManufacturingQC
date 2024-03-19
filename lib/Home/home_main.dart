import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pds_manufacturing_version/History/NewHistory.dart';
import 'package:pds_manufacturing_version/History/history_screen.dart';
import 'package:pds_manufacturing_version/Home/home_screen.dart';
import 'package:pds_manufacturing_version/Profile/profile_screen.dart';
import 'package:pds_manufacturing_version/methods.dart';
import 'package:simple_barcode_scanner/simple_barcode_scanner.dart';

class HomeMain extends StatefulWidget {
  @override
  _HomeMainState createState() => _HomeMainState();
}


class _HomeMainState extends State<HomeMain> {
  var qrstr = "let's Scan it";
  var height,width;
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  List pages = [  ProfileScreen(id: "id",
  name: "name",
  picurl: "",
  username: ""), HomeScreen(), NewHistory()];

  @override
  void initState() {
    super.initState();

  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    GetHistory();
    GetAllReads();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mintgreen,
      body: pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: mintgreen,
          boxShadow: [
            BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.1),
            )
          ],
        ),
        child: SafeArea(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
              child: GNav(
                rippleColor: mintgreen,
                hoverColor: mintgreen,
                gap: 8,
                activeColor: mintgreen,
                iconSize: 24,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Colors.white,
                color: Colors.black,
                tabs: [
                  GButton(
                    iconColor: Colors.white,
                    textColor: mintgreen,
                    icon: FontAwesomeIcons.user,
                    text: 'Profile',
                    onPressed: (){
                      setState(() {
                        GetAllReads();
                      });
                    },
                  ),
                  GButton(
                    iconColor: Colors.white,
                    textColor: mintgreen,
                    icon: FontAwesomeIcons.barcode,
                    text: 'Scan',
                    onPressed: (){},
                  ),
                  GButton(
                      iconColor: Colors.white,
                      textColor: mintgreen,
                      icon: FontAwesomeIcons.history,
                      text: 'History',
                      onPressed: (){
                        setState(() {
                        });
                      }
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      ),
    );;
  }
}