import 'package:flutter/material.dart';

void showdone(BuildContext context) {
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Container(
          height: 100,
          child: Column(
            children: const [
              CircularProgressIndicator(),
              SizedBox(
                height: 20,
              ),
              Text("ກຳລັງໂຫລດ...")
            ],
          ),
        ),
      );
    },
  );
}

void showDialogbox(BuildContext context, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Column(children: [
            const Icon(
              Icons.error,
              color: Colors.red,
              size: 50,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 18),
            )
          ]),
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "ຕົກລົງ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ))
          ],
        );
      });
}

void showDialogSuccess(BuildContext context, String title) {
  showDialog(
      context: context,
      builder: (context) {
        return SimpleDialog(
          title: Column(
            children: [
              const Icon(
                Icons.error,
                color: Colors.green,
                size: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                title,
                style: const TextStyle(fontSize: 18),
              )
            ],
          ),
          children: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "ຕົກລົງ",
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ))
          ],
        );
      });
}
