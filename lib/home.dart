import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'bluetooth.dart';
import 'controllers/tts_controller.dart';

class HomeScreen extends StatelessWidget {
  final TextEditingController txtcon = TextEditingController();
  final TextToSpeechController speakcontroller =
      Get.put(TextToSpeechController());

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color.fromARGB(255, 245, 242, 242),
      appBar: AppBar(
        title: GestureDetector(
            child: Image.asset('images/bluetooth3.png'),
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BluetoothScreen()),
                )),
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
      body: Column(children: [
        const SizedBox(height: 25),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.topCenter,
          child: const Text(
            'The World Need Your Voice',
            style: TextStyle(
              fontSize: 25,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 45),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          alignment: Alignment.topCenter,
          child: TextField(
            maxLines: 4,
            controller: txtcon,
            style: const TextStyle(
              fontSize: 24,
              color: Colors.pinkAccent,
              fontWeight: FontWeight.w700,
            ),
            textInputAction: TextInputAction.newline,
            onChanged: (value) {
              final lastChar = value.substring(value.length - 1);
              if (lastChar == '\n') {
                FocusScope.of(context).unfocus();
              }
            },
          ),
        ),
        const Expanded(child: Text("")),
        Image.asset("images/speakers.PNG"),
        const SizedBox(
          height: 35,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("images/listen.PNG"),
            const SizedBox(width: 10),
            GestureDetector(
              child: Image.asset("images/talk.PNG"),
              onTap: () async {
                debugPrint('speaking .. $txtcon.text');
                await speakcontroller.speak(txtcon.text);
              },
            ),
            const SizedBox(width: 10),
            Image.asset("images/off.PNG"),
          ],
        ),
        const SizedBox(
          height: 40,
        )
      ]),
    );
  }
}
