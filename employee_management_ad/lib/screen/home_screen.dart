import 'package:employee_management_ad/screen/home.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class HomeContent extends StatefulWidget {
  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: SizedBox(
                  height: size.height * .6,
                  width: size.width * .6,
                  child: Lottie.asset(
                    'assets/Animation - 1703909172112.json',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
