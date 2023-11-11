import 'package:flutter/material.dart';

import 'colors.dart';

var textInputDecoration = InputDecoration(
  hintStyle: TextStyle(
    color: AppColors.grey,
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.mainColor, width: 1),
    borderRadius: BorderRadius.circular(10),
  ),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.blueAccent, width: 1),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.blueAccent, width: 1),
  ),
);
