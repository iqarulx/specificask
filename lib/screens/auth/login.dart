import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:specificask/screens/ui/assets.dart';
import 'package:specificask/services/others/db.dart';
import 'package:specificask/utils/input_formats.dart';
import '../../services/api/auth_service.dart';
import '../../utils/validation.dart';
import '../screens/index.dart';
import '../ui/custom_field.dart';
import '../ui/loading.dart';
import '../ui/snackbar.dart';
import '/theme/theme.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _otp = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _mobileNumberVerified = false;
  String _generatedOtp = '';
  bool _otpVisible = false;

  _verifyMobileNumber() async {
    _otp.clear();
    _mobileNumberVerified = false;
    _generatedOtp = '';

    setState(() {});

    Future.delayed(
      const Duration(milliseconds: 100),
      () async {
        if (_formKey.currentState!.validate()) {
          try {
            futureLoading(context);
            var result = await AuthService.verifyMobileNumber(
                mobileNumber: _mobileNumber.text.trim());
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }

            _mobileNumberVerified = true;
            _generatedOtp = (result['otp_number']).toString();
            Snackbar.showSnackBar(context,
                content: "OTP has sent to mobile number");
            setState(() {});
          } catch (e) {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
            Snackbar.showSnackBar(context,
                content: e.toString(), isSuccess: false);
          }
        }
      },
    );
  }

  _verifyOtp() async {
    if (_formKey.currentState!.validate()) {
      if (_otp.text == _generatedOtp) {
        Snackbar.showSnackBar(context, content: "OTP verified");

        try {
          futureLoading(context);
          var user = await AuthService.getUserDetails(
              mobileNumber: _mobileNumber.text);
          await Db.setLogin(model: user);
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          Future.delayed(const Duration(seconds: 1), () {
            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(
                builder: (context) => const Index(),
              ),
            );
          });
        } catch (e) {
          if (Navigator.canPop(context)) {
            Navigator.pop(context);
          }
          Snackbar.showSnackBar(context,
              content: e.toString(), isSuccess: false);
        }
      } else {
        Snackbar.showSnackBar(context,
            content: "Incorrect OTP", isSuccess: false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: AutofillGroup(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Image.asset(ImageAssets.loginPad, height: 60, width: 60),
                ),
                const Divider(),
                const SizedBox(height: 10),
                Text(
                  "Login",
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Mobile Number",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor,
                          ),
                    ),
                    const SizedBox(height: 5),
                    CustomField(
                      controller: _mobileNumber,
                      prefixIcon: Icon(Iconsax.call,
                          color: AppColors.grey500, size: 20),
                      valid: (value) => Validation.validIndianMobileNumber(
                          input: value ?? '', isReq: true),
                      keyboardType: TextInputType.number,
                      hintText: "9000090000",
                      inputFormatters: InputFormats.numberOnly(length: 10),
                      suffixIcon: _mobileNumberVerified
                          ? Icon(Iconsax.verify, color: AppColors.greenColor)
                          : null,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "You will receive OTP for above mobile number",
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .copyWith(color: AppColors.grey400),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
                const SizedBox(height: 20),
                if (_mobileNumberVerified) ...[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "OTP",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: AppColors.greyColor,
                            ),
                      ),
                      const SizedBox(height: 5),
                      CustomField(
                        controller: _otp,
                        prefixIcon: Icon(Iconsax.security,
                            color: AppColors.grey500, size: 20),
                        valid: (value) => Validation.validOTP(
                            input: value ?? '', isReq: true),
                        keyboardType: TextInputType.number,
                        hintText: "0000",
                        inputFormatters: InputFormats.numberOnly(length: 4),
                        obscureText: !_otpVisible,
                        suffixIcon: IconButton(
                          onPressed: () => setState(() {
                            _otpVisible = !_otpVisible;
                          }),
                          icon: _otpVisible
                              ? const Icon(Iconsax.eye)
                              : const Icon(Iconsax.eye_slash),
                        ),
                      ),
                      const SizedBox(height: 5),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
                ElevatedButton(
                  onPressed: () => _mobileNumberVerified
                      ? _verifyOtp()
                      : _verifyMobileNumber(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    shadowColor: Colors.black.withOpacity(0.3),
                  ),
                  child: Text(
                    _mobileNumberVerified ? "Verify OTP" : "Send OTP",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
                if (_mobileNumberVerified) ...[
                  TextButton(
                    child: const Text("Resend OTP"),
                    onPressed: () => _verifyMobileNumber(),
                  )
                ]
              ],
            ),
          ),
        ),
      ),
    );
  }
}
