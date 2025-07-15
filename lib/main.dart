import 'dart:io';

import 'package:flutter/material.dart';

import 'app/src/app.dart';
import 'services/api/config.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = HttpOverridesImpl();
  runApp(const App());
}
