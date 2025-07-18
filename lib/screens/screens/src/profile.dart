import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import '/model/model.dart';
import '/services/services.dart';
import '/theme/theme.dart';
import '/screens/screens.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late Future _future;
  ProfileModel? _profileModel;

  @override
  void initState() {
    _future = _init();
    super.initState();
  }

  Future _init() async {
    _profileModel = await SettingsService.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      drawer: const Sidebar(screen: 'profile'),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const WaitingLoading();
          } else if (snapshot.hasError) {
            return ErrorDisplay(error: snapshot.error.toString());
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.pureWhiteColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: const [
                  BoxShadow(blurRadius: 3, color: Colors.grey),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundColor:
                            AppColors.primaryColor.withOpacity(0.5),
                        child: Text(
                          _profileModel?.name[0] ?? '',
                          style:
                              Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: AppColors.pureWhiteColor,
                                  ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _profileModel?.name ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(fontWeight: FontWeight.bold),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              _profileModel?.companyName ?? '',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyLarge!
                                  .copyWith(color: AppColors.greyColor),
                              overflow: TextOverflow.ellipsis,
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      const Icon(Iconsax.d_cube_scan),
                      const SizedBox(width: 10),
                      Text(
                        'Chapter Name : ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _profileModel?.chapterName ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Iconsax.buildings),
                      const SizedBox(width: 10),
                      Text(
                        'Business Type : ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _profileModel?.businessType ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Iconsax.call),
                      const SizedBox(width: 10),
                      Text(
                        'Mobile Number : ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _profileModel?.mobileNumber ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Iconsax.group),
                      const SizedBox(width: 10),
                      Text(
                        'Classification : ',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        _profileModel?.classification ?? '',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: AppColors.greyColor),
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                  TextButton.icon(
                    icon: const Icon(Iconsax.danger, size: 20),
                    label: const Text('Request to delete account'),
                    onPressed: () => Sheet.showSheet(context,
                        size: 0.9, widget: const DeleteAccountInstructions()),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class DeleteAccountInstructions extends StatefulWidget {
  const DeleteAccountInstructions({super.key});

  @override
  State<DeleteAccountInstructions> createState() =>
      _DeleteAccountInstructionsState();
}

class _DeleteAccountInstructionsState extends State<DeleteAccountInstructions> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30),
      ),
      child: Scaffold(
        backgroundColor: AppColors.pureWhiteColor,
        body: Padding(
          padding: const EdgeInsets.only(left: 15, bottom: 15, right: 15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Warning Before Deleting Your Account',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.redAccent,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 15),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          '• Your profile, including your BNI-specific data, will be permanently deleted.'),
                      SizedBox(height: 8),
                      Text(
                          '• You will no longer be able to access your group, chat history, or notifications.'),
                      SizedBox(height: 8),
                      Text(
                          '• All your shared media, uploaded documents, and notes will be removed.'),
                      SizedBox(height: 8),
                      Text(
                          '• Your connections with other members will be lost.'),
                      SizedBox(height: 8),
                      Text(
                          '• This action is irreversible — once deleted, your account cannot be recovered.'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'If you still wish to continue, click below to proceed with account deletion.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    try {
                      futureLoading(context);
                      var result = await SettingsService.requestDeleteAccount();
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      if (result) {
                        Snackbar.showSnackBar(context,
                            content: "Request submitted successfully");
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      Snackbar.showSnackBar(context,
                          content: e.toString(), isSuccess: false);
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
                    "Confirm Delete",
                    style: TextStyle(
                      fontSize: 16,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
