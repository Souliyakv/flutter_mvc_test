import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final box = GetStorage();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(const Duration(seconds: 3), () {
      check();
    });
  }

  check() {
    if (box.read("token") == null || box.read("token") == "") {
      Get.offNamed("/login");
    } else {
      Get.offNamed("/home");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 200,
            margin: const EdgeInsets.symmetric(vertical: 230, horizontal: 100),
            child: Lottie.asset("assets/flutter_logo.json", fit: BoxFit.cover),
          ),
          const Text(
            "@Flutter Test",
            style: TextStyle(fontSize: 18),
          )
        ],
      )),
    );
  }
}
