import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_mvc/model/product_model.dart';
import 'package:test_mvc/model/user_model.dart';
import 'package:test_mvc/utils/helper.dart';
import 'package:test_mvc/widget/widget.dart';
import '../config/config.dart';

class MainController extends GetxController {
  final box = GetStorage();
  var loading = true.obs;
  final Rxn<UserModel> _user = Rxn<UserModel>();
  var productList = <Product>[].obs;

  UserModel? get user => _user.value;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    await fetchProduct();
  }

  fetchProduct() async {
    try {
      loading(true);
      var url = Uri.parse("${END_POINTS}/product");
      var response = await http.get(url, headers: {'token': box.read("token")});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        var item = data["data"];
        productList.clear();
        productList.addAll(
            item.map<Product>((json) => Product.fromJson(json)).toList());
        loading(false);
        update();
      }
    } catch (e) {
      print("Error get Product is :${e}");
      loading(false);
      update();
    }
  }

  login(phone, password, context) async {
    try {
      var body = {"phone": phone, "password": password};
      var url = Uri.parse("${END_POINTS}/user/login");
      var response = await http.post(url, body: body);
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        Get.back();
        if (data['msg'] == "Invaild phone or password") {
          showDialogbox(context, "Invaild phone or password");
        } else {
          await setToken(data['token']);
          await getUserProfile(data['token']);
          Get.offAllNamed("/home");
          update();
        }
      }
    } catch (e) {
      print("Error login is :${e}");
    }
  }

  updateProfile(id, firstName, lastName, profile, context) async {
    try {
      var body = {
        "id": id.toString(),
        "firstName": firstName,
        "lastName": lastName,
        "profile": profile
      };
      var url = Uri.parse("${END_POINTS}/user/updateProfile");
      var response = await http
          .put(url, body: body, headers: {"token": box.read("token")});
      Get.back();
      if (response.statusCode == 201) {
        await box.remove("user");
        await getUserProfile(box.read("token"));
        showDialogSuccess(context, "update profile successful");
        fetchUserLocal();
        update();
      }
    } catch (e) {
      print("Error Update Profile is :${e}");
      showDialogbox(context, "update profile error");
    }
  }

  register(firstName, lastName, phone, password, context) async {
    try {
      var body = {
        "firstName": firstName,
        "lastName": lastName,
        "phone": phone,
        "password": password
      };
      var url = Uri.parse("${END_POINTS}/user/register");
      var response = await http.post(url, body: body);
      Get.back();
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        if (data['msg'] == "phone is already") {
          showDialogbox(context, "phone is already");
        } else {
          await setToken(data['token']);
          Get.offAllNamed("/home");
          update();
        }
      }
    } catch (e) {
      print("Error register is :${e}");
      showDialogbox(context, "Register Error");
    }
  }

  getUserProfile(token) async {
    try {
      loading(true);
      var url = Uri.parse("${END_POINTS}/user/profile");
      var response = await http.get(url, headers: {"token": token});
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        await storeUserData(data);
        loading(false);
        update();
      }
    } catch (e) {
      loading(false);
      print("Error get profile :${e}");
    }
  }

  setToken(token) async {
    try {
      await box.write("token", token);
    } catch (e) {
      print("Error token is :${e}");
    }
  }

  fetchUserLocal() async {
    try {
      if (box.hasData("token")) {
        loading(true);
        var user = await box.read('user');
        UserModel toJson = userFromJson(user);
        if (user != null) {
          _user.value = toJson;
          loading(false);
          update();
        }
      }
    } finally {
      loading(false);
    }
  }

  addProduct(name, desc, price, image, context) async {
    try {
      var body = {
        "name": name,
        "description": desc,
        "price": price,
        "image": image
      };
      var url = Uri.parse("${END_POINTS}/product");
      var response = await http
          .post(url, body: body, headers: {'token': box.read('token')});
      Get.back();
      if (response.statusCode == 200) {
        showDialogSuccess(context, "Add Product Success");
        fetchProduct();
        update();
      }
    } catch (e) {
      print("Error add Product is :${e}");
      showDialogbox(context, "Add product error");
      update();
    }
  }

  updateProduct(id, name, desc, price, image, context) async {
    try {
      var body = {
        "id": id.toString(),
        "name": name,
        "description": desc,
        "price": price,
        "image": image
      };
      var url = Uri.parse("${END_POINTS}/product");
      var response = await http
          .put(url, body: body, headers: {"token": box.read("token")});
      Get.back();

      if (response.statusCode == 201) {
        showDialogSuccess(context, "update product success");
        fetchProduct();
        update();
      }
    } catch (e) {
      print("Error update product is :${e}");
      showDialogbox(context, "Update Product Error");
      update();
    }
  }

  deleteProduct(id, context) async {
    try {
      var url = Uri.parse("${END_POINTS}/product/id");
      var response = await http.delete(url,
          body: {"id": id.toString()}, headers: {"token": box.read("token")});
      Get.back();
      if (response.statusCode == 200) {
        showDialogSuccess(context, "delete Success");
        fetchProduct();
        Get.offNamed("/home");
        update();
      }
    } catch (e) {
      print("Error delete product is :${e}");
      showDialogbox(context, "delete error");
      update();
    }
  }

  logout() async {
    await box.remove("token");
    await box.remove("user");
  }
}
