import 'package:metaozce/const/constant.dart';
import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  final String? title;
  const Background({
    Key? key,
    required this.child,
    required this.title,
    this.topImage = "assets/background.png",
    this.bottomImage = "assets/background1.png",
  }) : super(key: key);

  final String topImage, bottomImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${title}',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: kPrimaryLightColor,
      ),
      // bottomNavigationBar:
      resizeToAvoidBottomInset: false,
      body: Stack(
        fit: StackFit.expand,
        alignment: Alignment.center,
        children: <Widget>[
         /* Positioned(
            top: MediaQuery.of(context).size.height * 0,
            child: Image.asset(
              bottomImage,
            ),
            
          ),*/
          SafeArea(child: child),
        ],
      ),
    );
  }
}
