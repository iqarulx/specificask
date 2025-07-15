import 'package:flutter/material.dart';
import '/theme/theme.dart';

class ErrorDisplay extends StatelessWidget {
  final String error;
  const ErrorDisplay({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: AppColors.pureWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Error",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            SelectableText(
              error,
              style: TextStyle(color: AppColors.greyColor, fontSize: 13),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class NoData extends StatelessWidget {
  final Color? bgColor;
  final String? text;
  const NoData({super.key, this.bgColor, this.text});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: bgColor ?? AppColors.pureWhiteColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 10),
            Text(
              "No records",
              style: TextStyle(
                color: AppColors.blackColor,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            SelectableText(
              text ?? "No data available to show",
              style: TextStyle(color: AppColors.greyColor, fontSize: 13),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
