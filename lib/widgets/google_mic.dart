import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speak_loud/controllers/tts_controller.dart';
import 'package:speak_loud/controllers/stt_controller.dart';

class GoogleIconButton extends StatefulWidget {
  const GoogleIconButton(
      {Key? key,
      required this.buttonIcon,
      required this.buttonText,
      required this.handword})
      : super(key: key);

  final Icon buttonIcon;
  final String buttonText;
  final String handword;

  @override
  _GoogleIconButtonState createState() => _GoogleIconButtonState();
}

class _GoogleIconButtonState extends State<GoogleIconButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final TextToSpeechController tts = Get.put(TextToSpeechController());
  final SpeachToTextController stt = Get.put(SpeachToTextController());

  bool _isPressed = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );

    _scaleAnimation = Tween<double>(
      begin: 1,
      end: 0.8,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    if (widget.buttonText == "MOVE HAND") {
      tts.speak(widget.handword);
    } else {
      stt.listen();
    }

    _animationController.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    
    _animationController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    const iconColor = Colors.blue;
    const iconWeight = FontWeight.w600;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
          child: GestureDetector(
            onTapDown: _onTapDown,
            onTapUp: _onTapUp,
            onTapCancel: () {
              setState(() {
                _isPressed = false;
              });
              _animationController.reverse();
            },
            child: ScaleTransition(
              scale: _scaleAnimation,
              child: Material(
                elevation: 5.0,
                shape: const CircleBorder(),
                color: _isPressed ? Colors.grey[300] : Colors.white,
                child: SizedBox(
                  width: 72,
                  height: 72,
                  child: IconButton(
                    icon: widget.buttonIcon,
                    onPressed: () {},
                    color: Colors.blue,
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(15, 0, 15, 30),
          child: DefaultTextStyle(
            style:const TextStyle(
              color: iconColor,
              fontSize: 14,
              fontWeight: iconWeight,
            ),
            child: Text(widget.buttonText),
          ),
        ),
      ],
    );
  }
}
