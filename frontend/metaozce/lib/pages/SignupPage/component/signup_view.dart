import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metaozce/const/constant.dart';
import 'package:metaozce/pages/HomePage/home_screen.dart';
import 'package:metaozce/pages/SigninPage/signin_screen.dart';
import 'package:metaozce/pages/SignupPage/signup_screen.dart';

class SignupView extends StatefulWidget {
  const SignupView({Key? key}) : super(key: key);

  @override
  State<SignupView> createState() => _SignupViewState();
}

class _SignupViewState extends State<SignupView> {
  final TextEditingController controller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  final TextEditingController controllerFullname = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final controllerPasswordAgain = TextEditingController();
  bool isLogin =
      false; //giriş yapınca true olacak, dbye gönderilecek, öbür sayfalarda dbden çekilecek
  bool hidePassword = true;
  bool hidePasswordAgain = true;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Center(
            child: Form(
          key: formKey,
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
              /*  Image.asset(
                              "assets/logo/logodhp2.PNG",
                              width: 200,
                            ),*/
              Padding(
                padding:
                    EdgeInsets.only(left: 45, right: 45, bottom: 20, top: 30),
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "HELLO SIGN UP",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                      textAlign: TextAlign.center, // Metni ortala
                    ),
                    SizedBox(
                      height: defaultPadding * 11,
                    ),
                    buildFullname(),
                    const SizedBox(height: defaultPadding),
                    buildUsername(),
                    const SizedBox(height: defaultPadding),
                    buildPassword(),
                    const SizedBox(height: defaultPadding),
                    buildPasswordAgain(),
                    const SizedBox(height: defaultPadding),
                    const SizedBox(height: defaultPadding * 2),
                    buildLogin(),
                    const SizedBox(height: defaultPadding),
                    Center(//todo logolar buraya da gelebilir
                        ),
                    
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
        )),
      ],
    );
  }

  Widget buildLogin() => Builder(
        builder: (context) => SizedBox(
          width: double.infinity, // Genişlik ayarı
          child: ElevatedButton(
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (isValid) {
                print(controllerFullname);
                print(controllerUsername);
                print(controllerPassword);
                print(controllerPasswordAgain);
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomeScreen()),
                );
              }
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
  bool flagFullname = false;
  Widget buildFullname() => TextFormField(
        controller: controllerFullname,
        decoration: InputDecoration(
          // labelText: 'Username',
          hintText: "Full Name",
          suffixIcon: flagFullname ? Icon(Icons.check, color: iconColor) : null,
          icon: Icon(Icons.person),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagFullname
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: flagUsername
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
        ),
        style: TextStyle(
          color: flagFullname ? kPrimaryColor : grey,
        ),
        maxLength: 30,
        onChanged: (value) {
          setState(() {
            if (value!.length < 5) {
              flagFullname = false;
            } else {
              flagFullname = true;
            }
          });
        },
      );

  bool flagUsername = false;
  Widget buildUsername() => TextFormField(
        controller: controllerUsername,
        decoration: InputDecoration(
          // labelText: 'Username',
          hintText: "Username",
          suffixIcon: flagUsername ? Icon(Icons.check, color: iconColor) : null,
          icon: Icon(Icons.person),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagUsername
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: flagUsername
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
        ),
        style: TextStyle(
          color: flagUsername ? kPrimaryColor : grey,
        ),
        maxLength: 30,
        onChanged: (value) {
          setState(() {
            if (value!.length < 5) {
              flagUsername = false;
            } else {
              flagUsername = true;
            }
          });
        },
      );

  bool flagPassword = false;
  Widget buildPassword() => TextFormField(
        controller: controllerPassword,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePassword = !hidePassword;
              });
            },
            icon: Icon(
              hidePassword ? Icons.visibility_off : Icons.visibility,
              color: hidePassword ? grey : kPrimaryColor,
            ),
          ),
          //   labelText: 'Password',
          hintText: "Password",
          icon: Icon(Icons.lock),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagPassword
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: flagPassword
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          border: InputBorder.none, // Çerçeve yok
        ),
        style: TextStyle(
          color: flagPassword
              ? Color.fromARGB(255, 9, 129, 228)
              : Color.fromARGB(255, 168, 168, 168),
        ),
        maxLength: 20,
        onChanged: (value) {
          setState(() {
            if (value!.length < 7) {
              flagPassword = false;
            } else {
              flagPassword = true;
            }
          });
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: hidePassword,
      );

  bool flagPasswordAgain = false;
  Widget buildPasswordAgain() => TextFormField(
        controller: controllerPasswordAgain,
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                hidePasswordAgain = !hidePasswordAgain;
              });
            },
            icon: Icon(
              hidePasswordAgain ? Icons.visibility_off : Icons.visibility,
              color: hidePasswordAgain ? grey : kPrimaryColor,
            ),
          ),
          //   labelText: 'Password',
          hintText: "Password Again",
          icon: Icon(Icons.lock),
          fillColor: Colors.transparent,
          filled: true,
          focusedBorder: UnderlineInputBorder(
            borderSide: flagPasswordAgain
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: flagPasswordAgain
                ? BorderSide(color: kPrimaryColor)
                : BorderSide(color: grey),
          ),
          border: InputBorder.none, // Çerçeve yok
        ),
        style: TextStyle(
          color: flagPasswordAgain
              ? Color.fromARGB(255, 9, 129, 228)
              : Color.fromARGB(255, 168, 168, 168),
        ),
        maxLength: 20,
        onChanged: (value) {
          setState(() {
            if (value!.length < 7) {
              
              flagPasswordAgain = false;
            } else {
              flagPasswordAgain = true;
            }
          });
        },
        validator: (value) {
          if (value != controllerPassword.text) {
            return 'Passwords do not match';
          }
          return null;
        },
        keyboardType: TextInputType.visiblePassword,
        obscureText: hidePasswordAgain,
      );
}
