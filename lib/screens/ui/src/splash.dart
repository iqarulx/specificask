/*
  Copyright 2024 Srisoftwarez. All rights reserved.
  Use of this source code is governed by a BSD-style license that can be
  found in the LICENSE file.
*/

// Flutter imports:
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// Package imports:
import 'package:loading_animation_widget/loading_animation_widget.dart';

// Project imports:
import '/theme/theme.dart';
import 'assets.dart';

class Splash extends StatelessWidget {
  final String? content;
  const Splash({super.key, this.content});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );
    return Scaffold(
      backgroundColor: AppColors.pureWhiteColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Image(
              image: AssetImage(ImageAssets.logo),
              height: 140,
              width: 140,
            ),
            const SizedBox(height: 10),
            content != null
                ? Text(
                    content!,
                    style: Theme.of(context).textTheme.bodyLarge,
                  )
                : LoadingAnimationWidget.progressiveDots(
                    color: AppColors.primaryColor, size: 40),
          ],
        ),
      ),
    );
  }
}
