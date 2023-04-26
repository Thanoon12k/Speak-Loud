import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/flutter_stt_con.dart';
import 'controllers/stt_controller.dart';
import 'controllers/tts_controller.dart';
import 'bluetooth.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class HomeScreen extends StatelessWidget {
  final TextEditingController txtcon = TextEditingController();

  final TextToSpeechController tts_controller =
      Get.put(TextToSpeechController());
  final SpeachToTextController stt_controller =
      Get.put(SpeachToTextController());
  final FlutterSpeechController fstt_con = Get.put(FlutterSpeechController());

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
              "Reach To All",
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
          width: 350,
          height: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 5,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            border: Border.all(
              color: Colors.grey.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                tts_controller.mytext.value,
                style: const TextStyle(
                  fontSize: 26,
                  color: Colors.purple,
                  fontWeight: FontWeight.w700,
                  decorationColor: Colors.purple,
                  decorationThickness: 2,
                ),
              ),
            ),
          ),
        ),
        const Expanded(child: Text("")),
        const SizedBox(height: 35),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            listner_button(tts_controller: tts_controller, fstt_con: fstt_con),
          
            talker_button(tts_controller: tts_controller),
           
            // Image.asset("images/off.PNG"),
          ],
        ),
        const SizedBox(
          height: 40,
        )
      ]),
    );
  }
}

class talker_button extends StatelessWidget {
  const talker_button({
    super.key,
    required this.tts_controller,
  });

  final TextToSpeechController tts_controller;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset("images/talk.PNG"),
      onTap: () async {
        tts_controller.mytext.value = "how are you ....";
        await tts_controller.speak(tts_controller.mytext.value);
      },
    );
  }
}

class listner_button extends StatelessWidget {
  const listner_button({
    super.key,
    required this.tts_controller,
    required this.fstt_con,
  });

  final TextToSpeechController tts_controller;
  final FlutterSpeechController fstt_con;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset("images/listen.PNG"),
      onTap: () async {
        tts_controller.mytext.value = "speach to text started ...";
        fstt_con.startListening();
      },
    );
  }
}
