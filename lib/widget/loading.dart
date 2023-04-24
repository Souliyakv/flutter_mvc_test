import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 220),
              child: Lottie.asset(
                "assets/flutter_logo.json",
                height: 220,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            "ກຳລັງດາວໂຫລດຂໍ້ມູນ",
            style: TextStyle(fontSize: 18),
          ),
        ],
      )),
    );
  }
}
