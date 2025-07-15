import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '/theme/theme.dart';

class MySpecificAskListTable {
  final String count, datetime, name, specificAsk, connectedBy, connectedDate;
  final Widget convertToBusiness;

  MySpecificAskListTable(
    this.count,
    this.datetime,
    this.name,
    this.specificAsk,
    this.connectedBy,
    this.connectedDate,
    this.convertToBusiness,
  );
}

class MySpecificAskListTableDataSource extends DataGridSource {
  final List<DataGridRow> _tableData;

  MySpecificAskListTableDataSource({required List<MySpecificAskListTable> data})
      : _tableData = data
            .map<DataGridRow>(
              (e) => DataGridRow(
                cells: [
                  DataGridCell<String>(columnName: 'count', value: e.count),
                  DataGridCell<String>(
                      columnName: 'datetime', value: e.datetime),
                  DataGridCell<String>(columnName: 'name', value: e.name),
                  DataGridCell<String>(
                      columnName: 'specificAsk', value: e.specificAsk),
                  DataGridCell<String>(
                      columnName: 'connectedBy', value: e.connectedBy),
                  DataGridCell<String>(
                      columnName: 'connectedDate', value: e.connectedDate),
                  DataGridCell<Widget>(
                      columnName: 'convertToBusiness',
                      value: e.convertToBusiness),
                ],
              ),
            )
            .toList();

  @override
  List<DataGridRow> get rows => _tableData;

  @override
  DataGridRowAdapter buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map<Widget>((e) {
        if (e.columnName == 'convertToBusiness') {
          return Container(
            alignment: Alignment.center,
            child: e.value,
            color: Colors.white,
          );
        }
        return Container(
          color: Colors.white,
          alignment: Alignment.center,
          padding: const EdgeInsets.all(8.0),
          child: Text(
            e.value,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppColors.blackColor,
            ),
          ),
        );
      }).toList(),
    );
  }
}
