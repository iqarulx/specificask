import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/theme/theme.dart';

class CustomField extends StatelessWidget {
  final TextEditingController? controller;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? label;
  final TextInputType? keyboardType;
  final String? hintText;
  final int? maxLines;
  final Color? fillColor;
  final bool? readOnly;
  final bool? obscureText;
  final bool? enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String value)? onChanged;
  final void Function()? onTap;
  final String? Function(String? input)? valid;

  const CustomField({
    super.key,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.label,
    this.keyboardType,
    this.hintText,
    this.maxLines,
    this.onChanged,
    this.fillColor,
    this.readOnly,
    this.onTap,
    this.inputFormatters,
    this.valid,
    this.obscureText,
    this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Text(
            label!,
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  // fontWeight: FontWeight.bold,
                  color: AppColors.greyColor,
                ),
          ),
        TextFormField(
          controller: controller,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          readOnly: readOnly ?? false,
          keyboardType: keyboardType,
          enabled: enabled ?? true,
          maxLines: (obscureText == true)
              ? 1
              : (maxLines != null && maxLines! > 0 ? maxLines : null),
          obscureText: obscureText ?? false,
          onChanged: onChanged,
          inputFormatters: inputFormatters,
          validator: valid,
          onTap: onTap,
          style: const TextStyle(overflow: TextOverflow.ellipsis),
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey.shade400),
            filled: true,
            fillColor: fillColor ?? Colors.transparent,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xffFED0BB), width: 2),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Colors.red),
            ),
          ),
        ),
      ],
    );
  }
}
