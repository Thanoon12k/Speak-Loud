import 'package:flutter/material.dart';

class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({super.key});

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 242, 242),
        appBar: AppBar(
          title: Image.asset('images/bluetooth3.png'),
          actions: const [
            Center(
              child: Text(
                "Disabled Assistance",
                style: TextStyle(
                  fontFamily: AutofillHints.birthdayYear,
                  fontWeight: FontWeight.w700,
                  fontSize: 22,
                ),
              ),
            ),
            SizedBox(
              width: 15,
            )
          ],
          backgroundColor: const Color.fromARGB(255, 241, 147, 38),
          foregroundColor: Colors.black,
        ),
        body: Container(
          alignment: Alignment.center,
          child: Image.asset('images/bluetooth4'),
        ));
  }
}
