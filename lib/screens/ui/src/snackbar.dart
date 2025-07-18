/*
  Copyright 2024 Srisoftwarez. All rights reserved.
  Use of this source code is governed by a BSD-style license that can be
  found in the LICENSE file.
*/

// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:iconsax/iconsax.dart';

import '/theme/theme.dart';

class Snackbar {
  static void showSnackBar(BuildContext context,
      {required String content, bool isSuccess = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating, // Makes it float
        margin: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 12), // Adjust margin
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12)), // Rounded corners
        content: Row(
          children: [
            Icon(
              isSuccess ? Iconsax.tick_circle : Iconsax.close_circle,
              color: AppColors.pureWhiteColor,
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                content,
                overflow: TextOverflow.visible,
                style: TextStyle(color: AppColors.pureWhiteColor),
              ),
            ),
          ],
        ),
        backgroundColor: isSuccess ? AppColors.greenColor : AppColors.redColor,
      ),
    );
  }

  static void showSnackBarOption(context,
      {required String content,
      required bool isSuccess,
      required String actionText,
      required VoidCallback action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 10),
        content: Row(
          children: [
            Icon(
              isSuccess ? Iconsax.tick_circle : Iconsax.close_circle,
              color: AppColors.pureWhiteColor,
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
              child: Text(
                content,
                overflow: TextOverflow.visible,
                style: TextStyle(
                  color: AppColors.pureWhiteColor,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: isSuccess ? AppColors.greenColor : AppColors.redColor,
        action: SnackBarAction(
          label: actionText,
          textColor: AppColors.pureWhiteColor,
          onPressed: action,
        ),
      ),
    );
  }
}
