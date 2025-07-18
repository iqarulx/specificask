import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '/screens/screens.dart';
import '/services/services.dart';
import '/model/model.dart';
import '/theme/theme.dart';

class SpecificAskList extends StatefulWidget {
  const SpecificAskList({super.key});

  @override
  State<SpecificAskList> createState() => _SpecificAskListState();
}

class _SpecificAskListState extends State<SpecificAskList> {
  late Future _future;
  final List<SpecificAskModel> _specificAskList = [];
  SpecificAskListTableDataSource? _specificAskListTableDataSource;
  final List<SpecificAskListTable> _specificAskListTable = [];
  final GlobalKey<SfDataGridState> _specificAskListTableKey =
      GlobalKey<SfDataGridState>();
  final TextEditingController _fromDate = TextEditingController();
  final TextEditingController _toDate = TextEditingController();

  @override
  void initState() {
    _fromDate.text = DateTime.now()
        .subtract(const Duration(days: 7))
        .toString()
        .split(' ')[0];
    _toDate.text = DateTime.now().toString().split(' ')[0];
    _future = _init();
    super.initState();
  }

  Future _init() async {
    _specificAskList.clear();
    var result = await SpecificAskListService.fetchSpecificAsks(
        fromDate: _fromDate.text, toDate: _toDate.text);
    if (result.isNotEmpty) {
      _specificAskList.addAll(result);
    }

    _specificAskListTable.clear();
    for (var i in _specificAskList) {
      SpecificAskListTable table = SpecificAskListTable(
        i.count.toString(),
        i.datetime,
        i.name,
        i.specificAsk,
        i.connected
            ? const Text('Connected')
            : TextButton(
                onPressed: () async {
                  var result = await showDialog(
                    context: context,
                    builder: (context) {
                      return const CDialog(
                        title: 'Connect',
                        content: 'Are you sure want to connect?',
                      );
                    },
                  );
                  if (result != null && result) {
                    try {
                      futureLoading(context);
                      var result =
                          await SpecificAskListService.connect(id: i.id);
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                      }
                      if (result['code'] == '200') {
                        Snackbar.showSnackBar(context,
                            content: result['message']);
                        _future = _init();
                        setState(() {});
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
                child: Text(
                  'Yes I can connect',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.green),
                ),
              ),
      );
      _specificAskListTable.add(table);
    }

    _specificAskListTableDataSource =
        SpecificAskListTableDataSource(data: _specificAskListTable);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 5),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Row(
              children: [
                SizedBox(
                  width: 200,
                  child: CustomField(
                    controller: _fromDate,
                    readOnly: true,
                    hintText: 'From Date',
                    fillColor: AppColors.pureWhiteColor,
                    prefixIcon: const Icon(
                      Iconsax.calendar_1,
                      color: Colors.grey,
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980, 01, 01),
                        lastDate: DateTime(2100, 12, 31),
                      );
                      if (picked != null) {
                        _fromDate.text = picked.toString().split(' ')[0];
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: 200,
                  child: CustomField(
                    controller: _toDate,
                    readOnly: true,
                    hintText: 'To Date',
                    fillColor: AppColors.pureWhiteColor,
                    prefixIcon: const Icon(
                      Iconsax.calendar_1,
                      color: Colors.grey,
                    ),
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1980, 01, 01),
                        lastDate: DateTime(2100, 12, 31),
                      );
                      if (picked != null) {
                        _toDate.text = picked.toString().split(' ')[0];
                        setState(() {});
                      }
                    },
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    _future = _init();
                    setState(() {});
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
                    "Search",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: FutureBuilder(
            future: _future,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const WaitingLoading();
              } else if (snapshot.hasError) {
                return ErrorDisplay(error: snapshot.error.toString());
              }
              return SfDataGrid(
                key: _specificAskListTableKey,
                allowSorting: true,
                headerGridLinesVisibility: GridLinesVisibility.both,
                gridLinesVisibility: GridLinesVisibility.both,
                columnWidthMode: ColumnWidthMode.auto,
                rowHeight: 65,
                source: _specificAskListTableDataSource!,
                columns: <GridColumn>[
                  GridColumn(
                    width: 100,
                    columnName: 'count',
                    label: Container(
                      color: AppColors.pureWhiteColor,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'S.No',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'datetime',
                    label: Container(
                      color: AppColors.pureWhiteColor,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Datetime',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'name',
                    label: Container(
                      color: AppColors.pureWhiteColor,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Name',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'specificAsk',
                    label: Container(
                      color: AppColors.pureWhiteColor,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Specific Ask',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'convertToBusiness',
                    label: Container(
                      color: AppColors.pureWhiteColor,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Convert To Business',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
