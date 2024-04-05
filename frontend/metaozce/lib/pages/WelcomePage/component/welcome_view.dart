import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/HomePage/home_screen.dart';
import 'package:metaozce/pages/SigninPage/signin_screen.dart';
import 'package:metaozce/pages/SignupPage/signup_screen.dart';


class WelcomeView extends StatefulWidget {
  const WelcomeView({Key? key}) : super(key: key);

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
           
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  left: 8,
                  right: 8,
                ),
                child: Container(
                  width: MediaQuery.of(context).size.width * 3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  ),
                ),
              ),
             
              Padding(
                padding:
                    EdgeInsets.only(left: 45, right: 45, bottom: 20, top: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "WELCOME",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                      textAlign: TextAlign.center, // Metni ortala
                    ),
                    SizedBox(
                      height: defaultPadding * 11,
                    ),
                  
                    buildSignin(),
                    const SizedBox(height: defaultPadding),
                     buildSignup(),
                   
                    const SizedBox(height: defaultPadding),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: textColorMid, fontSize: 14),
                              children: [
                                //todo buraya logolar gelecek gmail vs.
                              ]),
                        ),
                      ),
                    ),
                    const SizedBox(height: defaultPadding*0.1),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.only(right: 0),
                        child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: textColorMid, fontSize: 14),
                              children: [
                                TextSpan(text: "Already have account?"),
                                TextSpan(
                                    text: " " + "Sign in",
                                    style: TextStyle(
                                      fontSize: 15,
                                      color: kPrimaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SigninScreen()));
                                      })
                              ]),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildSignin() => Builder(
        builder: (context) => SizedBox(
          width: double.infinity, // Genişlik ayarı
          child: ElevatedButton(
            onPressed: () {
             
             
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SigninScreen()),
                );
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor, // Buton rengi
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
              ),
              elevation: 4, // Butonun yüksekliği
              shadowColor: Colors.grey, // Gölgelenme rengi
              padding:
                  EdgeInsets.symmetric(vertical: 16), // Buton iç içe boşluk
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // Buton köşelerinin yuvarlanma derecesi
              ),
              minimumSize: Size(double.infinity, 50), // Butonun minimum boyutu
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Basılma boyutu
              animationDuration:
                  Duration(milliseconds: 300), // Animasyon süresi
              // Butona basıldığında ara rengin belirlenmesi
            ),
            child: Text("SIGN UP",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
        ),
      );
 

 
  Widget buildSignup() => Builder(
        builder: (context) => SizedBox(
          width: double.infinity, // Genişlik ayarı
          child: ElevatedButton(
            onPressed: () {
             
             
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignupScreen()),
                );
              
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: kPrimaryColor, // Buton rengi
              textStyle: TextStyle(
                fontSize: MediaQuery.of(context).size.width * 0.045,
              ),
              elevation: 4, // Butonun yüksekliği
              shadowColor: Colors.grey, // Gölgelenme rengi
              padding:
                  EdgeInsets.symmetric(vertical: 16), // Buton iç içe boşluk
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    50), // Buton köşelerinin yuvarlanma derecesi
              ),
              minimumSize: Size(double.infinity, 50), // Butonun minimum boyutu
              tapTargetSize: MaterialTapTargetSize.shrinkWrap, // Basılma boyutu
              animationDuration:
                  Duration(milliseconds: 300), // Animasyon süresi
              // Butona basıldığında ara rengin belirlenmesi
            ),
            child: Text("SIGN UP",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 20)),
          ),
        ),
      );
 
}
