/*
  Copyright 2024 Srisoftwarez. All rights reserved.
  Use of this source code is governed by a BSD-style license that can be
  found in the LICENSE file.
*/

// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import '/theme/theme.dart';

class SidebarOption extends StatelessWidget {
  final void Function() onTap;
  final String text;
  final IconData icon;
  final bool selected;
  const SidebarOption({
    super.key,
    required this.icon,
    required this.text,
    required this.onTap,
    this.selected = false,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: selected ? AppColors.primaryColor : AppColors.whiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const SizedBox(height: 5),
              Row(
                children: [
                  Icon(icon,
                      color: selected
                          ? AppColors.pureWhiteColor
                          : AppColors.blackColor),
                  const SizedBox(width: 12),
                  Text(
                    text,
                    style: TextStyle(
                      color: selected
                          ? AppColors.whiteColor
                          : AppColors.blackColor,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
            ],
          ),
        ),
      ),
    );
  }
}
