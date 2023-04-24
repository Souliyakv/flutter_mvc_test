import 'package:get/get.dart';
import 'package:test_mvc/pages/auth/login.dart';
import 'package:test_mvc/pages/auth/register.dart';
import 'package:test_mvc/pages/home/home.dart';

routes() => [
      GetPage(name: "/login", page: () => LoginPages()),
      GetPage(name: "/register", page: () => Register()),
      GetPage(name: "/home", page: () => HomePage())
    ];
