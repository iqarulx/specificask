import 'dart:io';

import 'package:flutter/material.dart';
import 'app/app.dart';
import 'services/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = HttpOverridesImpl();
  runApp(const App());
}
