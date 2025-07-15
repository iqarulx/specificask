import 'package:flutter/material.dart';
import 'package:specificask/screens/screens/my_specific_ask_list.dart';
import 'package:specificask/screens/screens/specific_ask_list.dart';

import '../../theme/theme.dart';
import '../sidebar/sidebar.dart';

class SpecificAskListIndex extends StatefulWidget {
  const SpecificAskListIndex({super.key});

  @override
  State<SpecificAskListIndex> createState() => _SpecificAskListIndexState();
}

class _SpecificAskListIndexState extends State<SpecificAskListIndex>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Specific Ask List"),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.pureWhiteColor,
          indicatorColor: AppColors.primaryColor,
          unselectedLabelColor: Colors.white54,
          physics: const NeverScrollableScrollPhysics(),
          tabs: const [
            Tab(text: 'Specific Ask'),
            Tab(text: 'My Request'),
          ],
        ),
      ),
      drawer: const Sidebar(screen: 'specificAskList'),
      body: TabBarView(
        controller: _tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: const [SpecificAskList(), MySpecificAskList()],
      ),
    );
  }
}
