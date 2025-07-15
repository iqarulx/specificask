import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:specificask/services/api/specific_ask_list_service.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../model/my_specific_ask_model.dart';
import '../../theme/theme.dart';
import '../ui/c_dialog.dart';
import '../ui/custom_field.dart';
import '../ui/error_display.dart';
import '../ui/loading.dart';
import '../ui/snackbar.dart';
import 'my_specifice_ask_list_table.dart';

class MySpecificAskList extends StatefulWidget {
  const MySpecificAskList({super.key});

  @override
  State<MySpecificAskList> createState() => _MySpecificAskListState();
}

class _MySpecificAskListState extends State<MySpecificAskList> {
  late Future _future;
  final List<MySpecificAskModel> _mySpecificAskList = [];
  MySpecificAskListTableDataSource? _mySpecificAskListTableDataSource;
  final List<MySpecificAskListTable> _mySpecificAskListTable = [];
  final GlobalKey<SfDataGridState> _mySpecificAskListTableKey =
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
    _mySpecificAskList.clear();
    var result = await SpecificAskListService.fetchMySpecificAsks(
        fromDate: _fromDate.text, toDate: _toDate.text);
    if (result.isNotEmpty) {
      _mySpecificAskList.addAll(result);
    }

    _mySpecificAskListTable.clear();
    for (var i = 0; i < _mySpecificAskList.length; i++) {
      MySpecificAskListTable table = MySpecificAskListTable(
        (i + 1).toString(),
        _mySpecificAskList[i].datetime,
        "${_mySpecificAskList[i].name}-${_mySpecificAskList[i].id}",
        _mySpecificAskList[i].specificAsk,
        _mySpecificAskList[i].connectedNames,
        _mySpecificAskList[i].connectedDate,
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CupertinoSwitch(
              onChanged: (value) async {
                if (_mySpecificAskList[i]
                        .connectedNames
                        .replaceAll('-', '')
                        .isEmpty &&
                    _mySpecificAskList[i]
                        .connectedDate
                        .replaceAll('-', '')
                        .isEmpty) {
                  return;
                }
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
                    var result = await SpecificAskListService.convertToBusiness(
                        checkValue: value,
                        id: _mySpecificAskList[i].connectedId);
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
              value: _mySpecificAskList[i].checked,
            ),
            const SizedBox(width: 5),
            Text(_mySpecificAskList[i].statusText),
          ],
        ),
      );
      _mySpecificAskListTable.add(table);
    }

    _mySpecificAskListTableDataSource =
        MySpecificAskListTableDataSource(data: _mySpecificAskListTable);

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
                key: _mySpecificAskListTableKey,
                allowSorting: true,
                headerGridLinesVisibility: GridLinesVisibility.both,
                gridLinesVisibility: GridLinesVisibility.both,
                columnWidthMode: ColumnWidthMode.auto,
                rowHeight: 65,
                source: _mySpecificAskListTableDataSource!,
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
                    columnName: 'MySpecificAsk',
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
                    columnName: 'connectedBy',
                    label: Container(
                      color: AppColors.pureWhiteColor,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Connected By',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'connectedDate',
                    label: Container(
                      color: AppColors.pureWhiteColor,
                      padding: const EdgeInsets.all(8.0),
                      alignment: Alignment.center,
                      child: const Text(
                        'Connected Date',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'convertToBusiness',
                    width: 230,
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
