import 'package:flutter/material.dart';

extension SizedBoxExtension on double {
  SizedBox get width => SizedBox(width: this);
  SizedBox get height => SizedBox(height: this);
  SizedBox get box => SizedBox(height: this, width: this);
}
