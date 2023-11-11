import 'package:flutter/material.dart';

showCustomMessage(BuildContext context, String title) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(title),
    ),
  );
}
