import 'package:flutter/material.dart';

class ErrorBadge extends StatelessWidget {
  final bool isVisible;
  final String message;

  const ErrorBadge({
    super.key,
    this.isVisible = false,
    this.message = "An error occured",
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      child: Container(
        width: double.maxFinite,
        padding: const EdgeInsets.all(10),
        decoration: const BoxDecoration(
          color: Colors.red,
        ),
        child: Text(message),
      ),
      opacity: isVisible ? 1 : 0,
      duration: const Duration(milliseconds: 500),
    );
  }
}
