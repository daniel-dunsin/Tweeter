import 'package:flutter/material.dart';

class CancelAppbarLeading extends StatelessWidget {
  final String text;
  final Function()? onTap;

  const CancelAppbarLeading({
    super.key,
    this.text = "Cancel",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 15, left: 15),
      child: GestureDetector(
        onTap: () {
          onTap == null ? Navigator.pop(context) : onTap!();
        },
        child: Text(
          text,
          style: TextStyle(
            fontSize: 13,
          ),
        ),
      ),
    );
  }
}
