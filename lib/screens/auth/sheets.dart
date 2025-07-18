import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:specificask/services/api/settings_service.dart';
import '../../model/posting_model.dart';
import '../ui/custom_field.dart';
import '../ui/error_display.dart';
import '../ui/loading.dart';
import '../ui/snackbar.dart';
import '/theme/theme.dart';

class Sheet {
  static Future<dynamic> showSheet(BuildContext context,
      {required Widget widget, required double size}) async {
    final value = await showModalBottomSheet(
      backgroundColor: AppColors.pureWhiteColor,
      useSafeArea: true,
      showDragHandle: true,
      isScrollControlled: true,
      enableDrag: true,
      shape: const RoundedRectangleBorder(
        side: BorderSide.none,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      context: context,
      transitionAnimationController: AnimationController(
        vsync: Navigator.of(context),
        duration: const Duration(milliseconds: 500),
      ),
      builder: (BuildContext builderContext) {
        return FractionallySizedBox(heightFactor: size, child: widget);
      },
    );
    return value;
  }
}

class PostingList extends StatefulWidget {
  const PostingList({super.key});

  @override
  State<PostingList> createState() => _PostingListState();
}

class _PostingListState extends State<PostingList> {
  final TextEditingController _search = TextEditingController();
  List<PostingModel> _postingList = [];
  List<PostingModel> _allPostingList = [];
  Future? _postingListHandler;

  void resetSearch() {
    setState(() {
      _postingList = List.from(_allPostingList);
    });
  }

  @override
  void initState() {
    super.initState();
    _postingListHandler = _getPosting();
  }

  Future _getPosting() async {
    try {
      _postingList.clear();
      _allPostingList.clear();
      setState(() {});

      List<PostingModel> r;

      r = await SettingsService.fetchPosting();

      if (r.isNotEmpty) {
        _allPostingList = r;
        _postingList = List.from(_allPostingList);
        _postingList.sort((a, b) => a.posting.compareTo(b.posting));
      }
      setState(() {});
    } catch (e) {
      Snackbar.showSnackBar(context, content: e.toString(), isSuccess: false);
    }
  }

  _searchCity() {
    List<PostingModel> filteredList = _allPostingList.where((posting) {
      return posting.posting.toLowerCase().contains(_search.text.toLowerCase());
    }).toList();

    setState(() {
      _postingList = filteredList;
    });
  }

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
          child: FutureBuilder(
            future: _postingListHandler,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingLoading();
              } else if (snapshot.hasError) {
                return ErrorDisplay(error: snapshot.error.toString());
              } else {
                return Column(
                  children: [
                    CustomField(
                      controller: _search,
                      prefixIcon: const Icon(Iconsax.search_normal),
                      hintText: "Search posting",
                      onChanged: (value) => _searchCity(),
                      fillColor: AppColors.pureWhiteColor,
                      suffixIcon: _search.text.isNotEmpty
                          ? TextButton(
                              onPressed: () {
                                _search.clear();
                                resetSearch();
                              },
                              child: Text(
                                "Clear",
                                style: TextStyle(
                                  color: AppColors.greyColor,
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(height: 10),
                    if (_postingList.isNotEmpty)
                      Flexible(
                        child: ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: _postingList.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.pop(context, _postingList[index]);
                              },
                              title: Text(
                                _postingList[index].posting,
                                style: TextStyle(color: AppColors.blackColor),
                              ),
                              tileColor: AppColors.transparent,
                              leading: Container(
                                height: 25,
                                width: 25,
                                decoration: BoxDecoration(
                                  color: AppColors.grey300,
                                  shape: BoxShape.circle,
                                ),
                                child: Center(
                                  child: Text(
                                    "${index + 1}",
                                    style: TextStyle(
                                      color: AppColors.greyColor,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              color: AppColors.grey300,
                            );
                          },
                        ),
                      )
                    else
                      NoData(bgColor: AppColors.pureWhiteColor)
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class ChapterNameList extends StatefulWidget {
  const ChapterNameList({super.key});

  @override
  State<ChapterNameList> createState() => _ChapterNameListState();
}

class _ChapterNameListState extends State<ChapterNameList> {
  final TextEditingController _search = TextEditingController();
  List<String> _chapterNameList = ['Pyros', 'Rocket', 'King Maker'];
  final List<String> _allChapterList = ['Pyros', 'Rocket', 'King Maker'];

  void resetSearch() {
    setState(() {
      _chapterNameList = List.from(_allChapterList);
    });
  }

  _searchCity() {
    List<String> filteredList = _allChapterList.where((chapterName) {
      return chapterName.toLowerCase().contains(_search.text.toLowerCase());
    }).toList();

    setState(() {
      _chapterNameList = filteredList;
    });
  }

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
          child: Column(
            children: [
              CustomField(
                controller: _search,
                prefixIcon: const Icon(Iconsax.search_normal),
                hintText: "Search chapterName",
                onChanged: (value) => _searchCity(),
                fillColor: AppColors.pureWhiteColor,
                suffixIcon: _search.text.isNotEmpty
                    ? TextButton(
                        onPressed: () {
                          _search.clear();
                          resetSearch();
                        },
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            color: AppColors.greyColor,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 10),
              if (_chapterNameList.isNotEmpty)
                Flexible(
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _chapterNameList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context, _chapterNameList[index]);
                        },
                        title: Text(
                          _chapterNameList[index],
                          style: TextStyle(color: AppColors.blackColor),
                        ),
                        tileColor: AppColors.transparent,
                        leading: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: AppColors.grey300,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.grey300,
                      );
                    },
                  ),
                )
              else
                NoData(bgColor: AppColors.pureWhiteColor)
            ],
          ),
        ),
      ),
    );
  }
}

class BusinessTypeList extends StatefulWidget {
  const BusinessTypeList({super.key});

  @override
  State<BusinessTypeList> createState() => _BusinessTypeListState();
}

class _BusinessTypeListState extends State<BusinessTypeList> {
  final TextEditingController _search = TextEditingController();
  List<String> _chapterNameList = ['Service', 'Manufacturer', 'Trader'];
  final List<String> _allChapterList = ['Service', 'Manufacturer', 'Trader'];

  void resetSearch() {
    setState(() {
      _chapterNameList = List.from(_allChapterList);
    });
  }

  _searchCity() {
    List<String> filteredList = _allChapterList.where((chapterName) {
      return chapterName.toLowerCase().contains(_search.text.toLowerCase());
    }).toList();

    setState(() {
      _chapterNameList = filteredList;
    });
  }

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
          child: Column(
            children: [
              CustomField(
                controller: _search,
                prefixIcon: const Icon(Iconsax.search_normal),
                hintText: "Search chapterName",
                onChanged: (value) => _searchCity(),
                fillColor: AppColors.pureWhiteColor,
                suffixIcon: _search.text.isNotEmpty
                    ? TextButton(
                        onPressed: () {
                          _search.clear();
                          resetSearch();
                        },
                        child: Text(
                          "Clear",
                          style: TextStyle(
                            color: AppColors.greyColor,
                          ),
                        ),
                      )
                    : null,
              ),
              const SizedBox(height: 10),
              if (_chapterNameList.isNotEmpty)
                Flexible(
                  child: ListView.separated(
                    primary: false,
                    shrinkWrap: true,
                    itemCount: _chapterNameList.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.pop(context, _chapterNameList[index]);
                        },
                        title: Text(
                          _chapterNameList[index],
                          style: TextStyle(color: AppColors.blackColor),
                        ),
                        tileColor: AppColors.transparent,
                        leading: Container(
                          height: 25,
                          width: 25,
                          decoration: BoxDecoration(
                            color: AppColors.grey300,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "${index + 1}",
                              style: TextStyle(
                                color: AppColors.greyColor,
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return Divider(
                        color: AppColors.grey300,
                      );
                    },
                  ),
                )
              else
                NoData(bgColor: AppColors.pureWhiteColor)
            ],
          ),
        ),
      ),
    );
  }
}
