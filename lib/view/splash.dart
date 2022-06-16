import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/records/record_home.dart';
import 'package:lottie/lottie.dart';


class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: ((context) => const RecordHome()))
      );
    });
    super.initState();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                width: 300,
                child: Lottie.asset(
                  "assets/animations/splash2.json",
                  frameRate: FrameRate.max,
                ),
              ),
            ],
          ),
        ),
      );
  }
}