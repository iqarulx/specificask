import 'package:flutter/material.dart';
import '/screens/screens.dart';
import '/model/model.dart';
import '/services/services.dart';
import '/theme/theme.dart';
import '/utils/utils.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _chapterName = TextEditingController();
  final TextEditingController _companyName = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _mobileNumber = TextEditingController();
  final TextEditingController _businessType = TextEditingController();
  final TextEditingController _classification = TextEditingController();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _posting = TextEditingController();
  PostingModel? _postingModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Image.asset(ImageAssets.loginPad,
                        height: 60, width: 60),
                  ),
                  const Divider(),
                  const SizedBox(height: 10),
                  Text(
                    "Request for new account",
                    style: Theme.of(context)
                        .textTheme
                        .titleLarge!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  CustomField(
                    controller: _chapterName,
                    hintText: "Select chapter name",
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    readOnly: true,
                    valid: (value) => Validation.commonValidation(
                        label: 'Chapter', input: value ?? '', isReq: true),
                    onTap: () async {
                      var result = await Sheet.showSheet(context,
                          size: 0.9, widget: const ChapterNameList());
                      if (result != null && result is String) {
                        _chapterName.text = result;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    controller: _companyName,
                    keyboardType: TextInputType.name,
                    hintText: "Enter company name",
                    valid: (value) => Validation.commonValidation(
                        label: 'Company Name', input: value ?? '', isReq: true),
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    controller: _name,
                    keyboardType: TextInputType.name,
                    hintText: "Enter name",
                    valid: (value) => Validation.commonValidation(
                        label: 'Name', input: value ?? '', isReq: true),
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    controller: _mobileNumber,
                    valid: (value) => Validation.validIndianMobileNumber(
                        input: value ?? '', isReq: true),
                    keyboardType: TextInputType.number,
                    hintText: "Enter mobile number",
                    inputFormatters: InputFormats.numberOnly(length: 10),
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    controller: _businessType,
                    hintText: "Select business type",
                    valid: (value) => Validation.commonValidation(
                        label: 'Business Type',
                        input: value ?? '',
                        isReq: true),
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    readOnly: true,
                    onTap: () async {
                      var result = await Sheet.showSheet(context,
                          size: 0.9, widget: const BusinessTypeList());
                      if (result != null && result is String) {
                        _businessType.text = result;
                        setState(() {});
                      }
                    },
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    controller: _classification,
                    keyboardType: TextInputType.name,
                    hintText: "Classification",
                    valid: (value) => Validation.commonValidation(
                        label: 'Classification',
                        input: value ?? '',
                        isReq: true),
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    controller: _posting,
                    hintText: "Select posting",
                    suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
                    readOnly: true,
                    onTap: () async {
                      var result = await Sheet.showSheet(context,
                          size: 0.9, widget: const PostingList());
                      if (result != null && result is PostingModel) {
                        _posting.text = result.posting;
                        _postingModel = result;
                        setState(() {});
                      }
                    },
                    valid: (value) => Validation.commonValidation(
                        label: 'Posting', input: value ?? '', isReq: true),
                  ),
                  const SizedBox(height: 10),
                  CustomField(
                    controller: _description,
                    keyboardType: TextInputType.text,
                    maxLines: 2,
                    hintText: "Description",
                  ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            try {
                              futureLoading(context);
                              var result =
                                  await AuthService.requestForNewAccount(data: {
                                'chapter_name': _chapterName.text,
                                'company_name': _companyName.text,
                                'name': _name.text,
                                'mobile_number': _mobileNumber.text,
                                'business_type': _businessType.text,
                                'classification': _classification.text,
                                'posting_id': _postingModel?.postingId,
                                'posting': _postingModel?.posting,
                                'description': _description.text,
                              });

                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                              if (result['code'] == '200') {
                                Snackbar.showSnackBar(context,
                                    content: "Request created successfully");
                                Navigator.pop(context);
                              } else {
                                Snackbar.showSnackBar(context,
                                    content: result['message'],
                                    isSuccess: false);
                              }
                            } catch (e) {
                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                              Snackbar.showSnackBar(context,
                                  content: e.toString(), isSuccess: false);
                            }
                          }
                        },
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
                        child: const Text(
                          "Apply Now",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      ElevatedButton(
                        onPressed: () => Navigator.pop(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.grey500,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 14),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 5,
                          shadowColor: Colors.black.withOpacity(0.3),
                        ),
                        child: const Text(
                          "Back",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
