import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:test_mvc/controller/main_controller.dart';
import 'package:test_mvc/widget/widget.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  final _formKey = GlobalKey<FormState>();
  final name = TextEditingController();
  final desc = TextEditingController();
  final price = TextEditingController();
  final MainController controller = Get.put(MainController());
  String? imgFile;
  File? file;

  Future chooseImage(ImageSource imageSource, BuildContext context) async {
    Navigator.pop(context);
    try {
      var object = await ImagePicker().getImage(source: imageSource);
      setState(() {
        file = File(object!.path);
        selectFile(context);
      });
    } catch (e) {
      print("Error choose image is :${e}");
    }
  }

  Future<void> selectFile(BuildContext context) async {
    if (file == null) return;
    File fileName = File(file!.path);
    Uint8List imagebytes = await fileName.readAsBytes();
    String base64string = base64.encode(imagebytes);
    imgFile = "data:image/jpg;base64,$base64string";

    setState(() {});
  }

  clearData() {
    setState(() {
      name.clear();
      desc.clear();
      price.clear();
      imgFile = "";
      file = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Product"),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(children: [
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: () {
                  _showDialog(context);
                },
                child: Container(
                  height: 110,
                  width: 110,
                  decoration: BoxDecoration(
                      color: Colors.yellow,
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: file == null
                      ? const Icon(Icons.add)
                      : Image.file(
                          file!,
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: name,
                validator: (value) {
                  if (value!.isEmpty || value.length < 0) {
                    return "Please Enter name product";
                  }
                  return null;
                },
                decoration: const InputDecoration(hintText: "name"),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: desc,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter desc';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'desc',
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: price,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter price';
                  }
                  return null;
                },
                decoration: const InputDecoration(
                  hintText: 'price',
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        showdone(context);
                        controller.addProduct(
                            name.text, desc.text, price.text, imgFile, context);
                        clearData();
                      }
                    },
                    child: const Text("+ Add Product"),
                  ),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Container(
            height: 120,
            child: Column(
              children: [
                ListTile(
                  onTap: () {
                    chooseImage(ImageSource.gallery, context);
                  },
                  leading: const Icon(Icons.camera),
                  title: const Text("gallery"),
                ),
                ListTile(
                  onTap: () {
                    chooseImage(ImageSource.camera, context);
                  },
                  leading: const Icon(Icons.camera_alt),
                  title: const Text("camera"),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
                // color: Colors.red,
                onPressed: () {
                  Get.back();
                },
                child: const Text(
                  'ຍົກເລີກ',
                  style: TextStyle(
                      color: Colors.green, fontWeight: FontWeight.bold),
                ))
          ],
        );
      },
    );
  }
}
