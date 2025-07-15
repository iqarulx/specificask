import 'package:flutter/material.dart';
import 'package:specificask/screens/ui/custom_field.dart';
import 'package:specificask/screens/ui/error_display.dart';
import 'package:specificask/screens/ui/loading.dart';
import 'package:specificask/services/others/db.dart';
import 'package:specificask/theme/theme.dart';

import '../../services/api/specific_ask_service.dart';
import '../sidebar/sidebar.dart';
import '../ui/snackbar.dart';

class SpecificAsk extends StatefulWidget {
  const SpecificAsk({super.key});

  @override
  State<SpecificAsk> createState() => _SpecificAskState();
}

class _SpecificAskState extends State<SpecificAsk> {
  late Future _future;
  Map<String, dynamic> _userDetails = {};
  final TextEditingController _specificAsk = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _future = _init();
    super.initState();
  }

  Future _init() async {
    _userDetails = await Db.getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Specific Ask"),
      ),
      drawer: const Sidebar(screen: 'specificAsk'),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingLoading();
          } else if (snapshot.hasError) {
            return ErrorDisplay(error: snapshot.error.toString());
          } else {
            return ListView(
              padding: const EdgeInsets.all(8),
              children: [
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.pureWhiteColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Chapter Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.grey600),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${_userDetails['chapterName']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.blackColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Company Name',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.grey600),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${_userDetails['companyName']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.blackColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Business Type',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.grey600),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10.0),
                              child: Text(
                                '${_userDetails['businessType']}',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge!
                                    .copyWith(color: AppColors.blackColor),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Form(
                  key: _formKey,
                  child: CustomField(
                    controller: _specificAsk,
                    maxLines: 4,
                    fillColor: AppColors.pureWhiteColor,
                    hintText: "Enter your description here...",
                    valid: (input) {
                      if (input == null || input.isEmpty) {
                        return "Please enter your description";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      try {
                        futureLoading(context);
                        var result = await SpecificAskService.addSpecificAsk(
                            mobileNumber: _userDetails['mobileNumber']);
                        if (Navigator.canPop(context)) {
                          Navigator.pop(context);
                        }
                        if (result['code'] == '200') {
                          Snackbar.showSnackBar(context,
                              content: result['message']);
                          _specificAsk.clear();
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
                    "Submit",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }
}
