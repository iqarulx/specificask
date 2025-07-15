/*
  Copyright 2024 Srisoftwarez. All rights reserved.
  Use of this source code is governed by a BSD-style license that can be
  found in the LICENSE file.
*/

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '/theme/theme.dart';
import 'list_options.dart';
import 'logout.dart';

class Sidebar extends StatefulWidget {
  final String screen;
  const Sidebar({super.key, required this.screen});

  @override
  State<Sidebar> createState() => _SidebarState();
}

class _SidebarState extends State<Sidebar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: AppColors.pureWhiteColor,
        surfaceTintColor: AppColors.blackColor,
        shadowColor: AppColors.blackColor,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListOptions(screen: widget.screen),
              const Logout(),
            ],
          ),
        ),
      ),
    );
  }
}
