import 'package:flutter/material.dart';
import '/theme/theme.dart';
import '/screens/screens.dart';

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
