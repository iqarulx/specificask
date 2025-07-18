import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '/screens/screens.dart';
import '/services/services.dart';
import '/utils/utils.dart';
import '/theme/theme.dart';

class ListOptions extends StatefulWidget {
  final String screen;
  const ListOptions({super.key, required this.screen});

  @override
  State<ListOptions> createState() => _ListOptionsState();
}

class _ListOptionsState extends State<ListOptions> {
  late Future _userHanlder;
  Map<String, dynamic> _userDetails = {};
  bool _isSameDay = false;

  @override
  void initState() {
    _userHanlder = _getUser();
    super.initState();
  }

  Future _getUser() async {
    _userDetails = await Db.getData();
    final now = DateTime.now();
    final dayName = DateFormat('EEEE').format(now);

    var specificAskDay = await SettingsService.fetchSpecificAskDay();
    if (specificAskDay == dayName) {
      _isSameDay = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _userHanlder,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const SizedBox(height: 10),
                Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(context).primaryColor,
                      radius: 25,
                      child: _userDetails.isNotEmpty
                          ? Text(
                              _userDetails['name'].toString()[0],
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${getTimeWish()} ,',
                            style: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .copyWith(color: AppColors.grey600),
                          ),
                          Text(
                            '${_userDetails['name']}.',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(color: AppColors.blackColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(
                  color: AppColors.greyColor,
                  indent: 10,
                  endIndent: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (_isSameDay)
                      SidebarOption(
                        icon: Iconsax.task,
                        text: "Specific Ask",
                        selected: widget.screen == 'specificAsk',
                        onTap: () {
                          if (widget.screen == 'specificAsk') {
                            if (Navigator.canPop(context)) {
                              Navigator.pop(context);
                            }
                          } else {
                            Navigate.route(context, const SpecificAsk());
                          }
                        },
                      ),
                    const SizedBox(height: 5),
                    SidebarOption(
                      icon: Iconsax.activity,
                      text: "Specific Ask List",
                      selected: widget.screen == 'specificAskList',
                      onTap: () {
                        if (widget.screen == 'specificAskList') {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        } else {
                          Navigate.route(context, const SpecificAskListIndex());
                        }
                      },
                    ),
                    const SizedBox(height: 5),
                    SidebarOption(
                      icon: Iconsax.user,
                      text: "Profile",
                      selected: widget.screen == 'profile',
                      onTap: () {
                        if (widget.screen == 'profile') {
                          if (Navigator.canPop(context)) {
                            Navigator.pop(context);
                          }
                        } else {
                          Navigate.route(context, const Profile());
                        }
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Shimmer.fromColors(
                  baseColor: AppColors.grey300,
                  highlightColor: AppColors.grey100,
                  child: CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    radius: 25,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Shimmer.fromColors(
                        baseColor: AppColors.grey300,
                        highlightColor: AppColors.grey100,
                        child: Container(
                          width: 100,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.pureWhiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      Shimmer.fromColors(
                        baseColor: AppColors.grey300,
                        highlightColor: AppColors.grey100,
                        child: Container(
                          width: double.infinity,
                          height: 20,
                          decoration: BoxDecoration(
                            color: AppColors.pureWhiteColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
