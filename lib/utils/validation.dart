/*
  Copyright 2024 Srisoftwarez. All rights reserved.
  Use of this source code is governed by a BSD-style license that can be
  found in the LICENSE file.
*/

class Validation {
  static String? commonValidation(
      {required String input, required String label, required bool isReq}) {
    if (isReq) {
      if (input.isEmpty) {
        return "$label is required";
      }
    }
    return null;
  }

  static String? validOTP({required String input, bool? isReq}) {
    if (isReq ?? false) {
      if (input.isEmpty) {
        return 'OTP is required';
      }
    }

    if (input.isNotEmpty) {
      if (!RegExp(r'^\d{4}$').hasMatch(input)) {
        return 'OTP must be exactly 4 digits';
      }
    }

    return null;
  }

  static String? validIndianMobileNumber({required String input, bool? isReq}) {
    if (isReq ?? false) {
      if (input.isEmpty) {
        return 'Mobile number is required';
      }
    }
    if (input.isNotEmpty) {
      if (!RegExp(r'^[6-9]\d{9}$').hasMatch(input)) {
        return 'Invalid mobile number';
      }
    }
    return null;
  }

  static String? validUrl({required String input, bool? isReq}) {
    if (isReq ?? false) {
      if (input.isEmpty) {
        return 'Url is required';
      }
    }
    if (input.isNotEmpty) {
      if (!RegExp(r'^(http|https)://[^\s/$.?#].[^\s]*$').hasMatch(input)) {
        return 'Invalid url';
      }
    }
    return null;
  }

  static String? passwordValidation({required String input}) {
    if (input.length < 8) {
      return "Must be at least 8 characters long";
    }

    if (!RegExp(r'[A-Z]').hasMatch(input)) {
      return "Must contain at least one uppercase letter";
    }

    if (!RegExp(r'[a-z]').hasMatch(input)) {
      return "Must contain at least one lowercase letter";
    }

    if (!RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(input)) {
      return "Must contain at least one special character";
    }

    if (!RegExp(r'\d').hasMatch(input)) {
      return "Must contain at least one number";
    }

    return null;
  }

  static String? validAddress({required String input, bool isReq = false}) {
    if (isReq && input.isEmpty) {
      return 'Address is required';
    }

    if (input.isNotEmpty) {
      if (input.length > 150) {
        return 'Address is too long (max 150 characters)';
      }

      if (!RegExp(r'^[a-zA-Z0-9\s,.\-#/]+$').hasMatch(input)) {
        return 'Invalid characters in address';
      }
    }

    return null;
  }
}
