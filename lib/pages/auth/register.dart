import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_mvc/controller/main_controller.dart';
import 'package:test_mvc/widget/widget.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final fname = TextEditingController();
  final lname = TextEditingController();
  final phone = TextEditingController();
  final password = TextEditingController();
  final _form = GlobalKey<FormState>();
  final MainController controller = Get.put(MainController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Register")),
        body: Form(
          key: _form,
          child: SingleChildScrollView(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Image.asset(
                  "assets/Privacy-policy-bro.png",
                  height: 120,
                ),
                Text(
                  'Create your Account',
                  style: TextStyle(fontSize: 20),
                ),
                TextFormField(
                  controller: fname,
                  decoration: InputDecoration(hintText: 'firstName'),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "firstName is require";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lname,
                  decoration: InputDecoration(hintText: 'lastName'),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "lastName is require";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phone,
                  decoration: InputDecoration(hintText: 'phone'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "phone is require";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: password,
                  decoration: InputDecoration(hintText: 'password'),
                  validator: (value) {
                    if (value!.isEmpty || value == null) {
                      return "password is require";
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Container(
                    height: 50,
                    width: 200,
                    child: ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            showdone(context);
                            controller.register(fname.text, lname.text,
                                phone.text, password.text, context);
                          }
                        },
                        child: const Text("Register")))
              ],
            ),
          )),
        ));
  }
}
