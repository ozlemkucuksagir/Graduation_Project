import 'package:flutter/material.dart';
import 'package:metaozce/pages/HomePage/home_screen.dart';
import 'package:metaozce/pages/SignupPage/signup_screen.dart';
import 'package:metaozce/const/constant.dart';


import 'entity/profile_menu.dart';
import 'entity/profile_pic.dart';

class ProfileScreenView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          ProfilePic(),
          SizedBox(height: 20),
          ProfileMenu(
            text: "Hesap",
            icon: Icon(
              Icons.person,
               color: kPrimaryColor,
            ),
            press: () => {},
          ),
          
          ProfileMenu(
            text: "Bildirimler",
            icon: Icon(Icons.notifications,  color: kPrimaryColor,),
            
            press: () {},
          ),
          ProfileMenu(
            text: "Ayarlar",
            icon: Icon(Icons.settings,  color: kPrimaryColor,),
            press: () {},
          ),
          ProfileMenu(
            text: "Geri Dönüş",
            icon: Icon(Icons.feedback,  color: kPrimaryColor,),
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => HomeScreen())),
          ),
          ProfileMenu(
            text: "Çıkış Yap",
            icon: Icon(Icons.logout,  color: kPrimaryColor,),
            press: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupScreen())),
          ),
        ],
      ),
    );
  }
}
