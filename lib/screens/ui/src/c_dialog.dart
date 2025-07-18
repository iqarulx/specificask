import 'package:flutter/material.dart';
import '/theme/theme.dart';

class CDialog extends StatefulWidget {
  final String title;
  final String content;
  final String? successText;
  final String? cancelText;
  const CDialog(
      {super.key,
      required this.title,
      required this.content,
      this.successText,
      this.cancelText});

  @override
  State<CDialog> createState() => _CDialogState();
}

class _CDialogState extends State<CDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: AppColors.pureWhiteColor,
      surfaceTintColor: AppColors.pureWhiteColor,
      insetPadding: const EdgeInsets.all(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide.none,
      ),
      title: Text(widget.title),
      content: Text(widget.content),
      actions: [
        Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, false);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.pureWhiteColor,
                  ),
                  child: Center(
                    child: Text(
                      widget.cancelText ?? "Cancel",
                      style: TextStyle(
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context, true);
                },
                child: Container(
                  height: 55,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.primaryColor,
                  ),
                  child: Center(
                    child: Text(
                      widget.successText ?? "Confirm",
                      style: TextStyle(
                        color: AppColors.pureWhiteColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
