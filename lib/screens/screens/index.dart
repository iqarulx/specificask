import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:specificask/screens/screens/specific_ask.dart';
import 'package:specificask/screens/ui/splash.dart';
import 'package:specificask/services/api/settings_service.dart';

import 'specific_ask_list_index.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late Future _future;
  bool _isSameDay = false;

  @override
  void initState() {
    _future = _init();
    super.initState();
  }

  Future<void> _init() async {
    final now = DateTime.now();
    final dayName = DateFormat('EEEE').format(now);

    var specificAskDay = await SettingsService.fetchSpecificAskDay();
    if (specificAskDay == dayName) {
      _isSameDay = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Splash();
        } else if (snapshot.hasError) {
          return Splash(content: snapshot.error.toString());
        }
        if (_isSameDay) {
          return const SpecificAsk();
        } else {
          return const SpecificAskListIndex();
        }
      },
    );
  }
}
