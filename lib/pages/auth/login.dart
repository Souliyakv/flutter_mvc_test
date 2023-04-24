import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_mvc/controller/main_controller.dart';
import 'package:test_mvc/widget/widget.dart';

class LoginPages extends StatefulWidget {
  const LoginPages({super.key});

  @override
  State<LoginPages> createState() => _LoginPagesState();
}

class _LoginPagesState extends State<LoginPages> {
  final phone = TextEditingController();
  final password = TextEditingController();
  final _form = GlobalKey<FormState>();
  MainController mainController = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
        centerTitle: true,
      ),
      body: Form(
          key: _form,
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Column(children: [
                Image.asset(
                  "assets/Privacy-policy-bro.png",
                  height: 120,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "Login your Account",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(hintText: "Phone"),
                  validator: (value) {
                    if (value!.isEmpty || value.length != 8) {
                      return "ເບີໂທລະສັບຕ້ອງມີ 8 ໂຕອັກສອນ";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 10),
                TextFormField(
                  controller: password,
                  decoration: const InputDecoration(
                    hintText: "password",
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "password is require";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () {
                      if (_form.currentState!.validate()) {
                        showdone(context);
                        mainController.login(
                            phone.text, password.text, context);
                      }
                    },
                    child: const Text("Login"),
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          Get.toNamed("/register");
                        },
                        child: Text("Register")))
              ]),
            ),
          )),
    );
  }
}
