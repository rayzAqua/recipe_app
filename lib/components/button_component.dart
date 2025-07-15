import 'package:flutter/material.dart';
import 'package:pratical_flutter/models/button_model.dart';

class ButtonComponent extends StatelessWidget {
  final ButtonDataModel buttonData;
  final VoidCallback onButtonToggle;

  const ButtonComponent({
    super.key,
    required this.buttonData,
    required this.onButtonToggle,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onButtonToggle,
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        backgroundColor: buttonData.isPressed ? Colors.amber : Colors.white,
        foregroundColor: buttonData.isPressed ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        side: BorderSide(
          color: buttonData.isPressed ? Colors.amber : Colors.black,
        ),
      ),
      child: Text(
        buttonData.title,
        style: TextStyle(fontSize: 10),
        textAlign: TextAlign.center,
      ),
    );
  }
}
