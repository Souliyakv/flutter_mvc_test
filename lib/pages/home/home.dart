import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_mvc/controller/main_controller.dart';
import 'package:test_mvc/model/product_model.dart';
import 'package:test_mvc/pages/home/add_product.dart';
import 'package:test_mvc/pages/home/detail.dart';
import 'package:test_mvc/pages/home/editprofile.dart';
import 'package:test_mvc/widget/loading.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final box = GetStorage();
  final MainController controller = Get.put(MainController());

  @override
  void initState() {
    // TODO: implement initState
    controller.fetchUserLocal();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx((() {
      if (controller.loading.value) {
        return const LoadingPage();
      } else {
        return Scaffold(
          appBar: AppBar(
            leading: Padding(
              padding: const EdgeInsets.all(5),
              child: InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditProfile(),
                    )),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(50)),
                  child: controller.user!.profile == null ||
                          controller.user!.profile == ""
                      ? Image.asset(
                          "assets/user.png",
                          fit: BoxFit.cover,
                        )
                      : Image.network(
                          "${controller.user!.profile}",
                          fit: BoxFit.cover,
                        ),
                ),
              ),
            ),
            title: const Text("Home Screen"),
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () async {
                    controller.logout();
                    Get.offAllNamed("/login");
                  },
                  icon: const Icon(Icons.exit_to_app))
            ],
          ),
          body: SingleChildScrollView(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddProduct(),
                        )),
                    child: const Text(
                      "+ ເພີ່ມສິນຄ້າ",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount: controller.productList.length,
                primary: false,
                itemBuilder: (context, index) {
                  Product data = controller.productList[index] as Product;
                  return InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return Detail(product: data);
                        },
                      ));
                    },
                    child: Card(
                        elevation: 5,
                        color: Colors.white,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8),
                              child: Image.network(
                                data.image,
                                fit: BoxFit.cover,
                                height: 100,
                                width: 100,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                width: 220,
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "${data.name}",
                                        style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${data.description}",
                                      ),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Text(
                                        "₭${data.price}",
                                        style: const TextStyle(
                                            fontSize: 20,
                                            color: Colors.red,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ]),
                              ),
                            )
                          ],
                        )),
                  );
                },
              )
            ],
          )),
        );
      }
    }));
  }
}
