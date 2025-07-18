/*
  Copyright 2024 Srisoftwarez. All rights reserved.
  Use of this source code is governed by a BSD-style license that can be
  found in the LICENSE file.
*/

// Flutter imports:
import 'package:flutter/services.dart';

class InputFormats {
  static List<TextInputFormatter> numberOnly({int? length}) {
    return length != null
        ? [
            FilteringTextInputFormatter.digitsOnly,
            LengthLimitingTextInputFormatter(length),
          ]
        : [
            FilteringTextInputFormatter.digitsOnly,
          ];
  }

  static List<TextInputFormatter> amountOnly({int? length}) {
    return length != null
        ? [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
            LengthLimitingTextInputFormatter(length),
          ]
        : [
            FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
          ];
  }

  static List<TextInputFormatter> maxString({required int length}) {
    return [LengthLimitingTextInputFormatter(length)];
  }

  static List<TextInputFormatter> numberWithPercent() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[0-9.%]')),
    ];
  }

  static List<TextInputFormatter> alphabetsOnly() {
    return [
      FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z]')),
    ];
  }

  static List<TextInputFormatter> toUpperCase() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        return TextEditingValue(
          text: newValue.text.toUpperCase(),
          selection: newValue.selection,
        );
      }),
    ];
  }

  static List<TextInputFormatter> toLowerCase() {
    return [
      TextInputFormatter.withFunction((oldValue, newValue) {
        return TextEditingValue(
          text: newValue.text.toLowerCase(),
          selection: newValue.selection,
        );
      }),
    ];
  }
}
