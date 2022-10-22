import 'dart:convert';
import 'dart:js';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_cell_props/data_cell_props.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_row_props/data_row_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_RowData extends AsyncDataTableSource {
  final BuildContext context;
  late List<DataRowProps> rows;
  late List<dynamic> tableData;
  late Function(int rowIndex, bool isSelected) handleSelectRow;
  late String pagePath;
  late Future<SourceRowDataResponse> Function(int, int, String?, bool?)
      getDataFunction;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  bool _empty = false;
  int? _errorCounter;
  String? _sortColumn;
  bool? _sortAscending;

  T_RowData(
    this.context, {
    required this.rows,
    required this.tableData,
    required this.pagePath,
    required this.getDataFunction,
    required this.handleSelectRow,
    this.hasRowTaps = false,
    this.hasRowHeightOverrides = false,
    this.hasZebraStripes = false,
  }) {
    // if (sortedByCalories) {
    //   sort((d) => d.calories, true);
    // }
  }

  T_RowData.empty(this.context) {
    tableData = [];
  }

  // @override
  // DataRow? getRow(int index) {
  //   final format = NumberFormat.decimalPercentPattern(
  //     locale: 'en',
  //     decimalDigits: 0,
  //   );
  //   assert(index >= 0);
  //   if (index >= tableData.length) throw 'index > rowData.length';
  //   final rowData = tableData[index];
  //   return DataRow2.byIndex(
  //     index: index,
  //     selected: UtilsManager.isTruthy(rowData["selected"]),
  //     // color: color != null
  //     //     ? MaterialStateProperty.all(color)
  //     //     : (hasZebraStripes && index.isEven
  //     //         ? MaterialStateProperty.all(Theme.of(context).highlightColor)
  //     //         : null),
  //     onSelectChanged: (value) {
  //       if (UtilsManager.isTruthy(rowData["selected"]) != value) {
  //         _selectedCount += value! ? 1 : -1;
  //         assert(_selectedCount >= 0);
  //         handleSelectRow(index, value);
  //         notifyListeners();
  //       }
  //     },
  //     onTap: hasRowTaps ? () => _showSnackbar(context, 'Tapped on row') : null,
  //     onDoubleTap: hasRowTaps
  //         ? () => _showSnackbar(context, 'Double Tapped on row')
  //         : null,
  //     onLongPress: hasRowTaps
  //         ? () => _showSnackbar(context, 'Long pressed on row')
  //         : null,
  //     onSecondaryTap: hasRowTaps
  //         ? () => _showSnackbar(context, 'Right clicked on row')
  //         : null,
  //     onSecondaryTapDown: hasRowTaps
  //         ? (d) => _showSnackbar(context, 'Right button down on row')
  //         : null,
  //     // specificRowHeight:
  //     //     hasRowHeightOverrides && dessert.fat >= 25 ? 100 : null,
  //     cells: _computeCells(rows[0].cells, tableData[index]),
  //   );
  // }

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    print('getRows($start, $end)');
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    var index = start;
    // final format = NumberFormat.decimalPercentPattern(
    //   locale: 'en',
    //   decimalDigits: 0,
    // );
    assert(index >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var tableData = await getDataFunction(
      start,
      end,
      _sortColumn,
      _sortAscending,
    );

    print(
      "abcd tableData ${tableData.data} ${tableData.data.toList()}",
    );

    var row = AsyncRowsResponse(
        tableData.total,
        tableData.data.map((rowData) {
          return DataRow(
            key: ValueKey<int>(rowData["id"]),
            selected: rowData["selected"] ?? false,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(ValueKey<int>(rowData["id"]), value);
              }
            },
            cells: _computeCells(rows[0].cells, rowData),
          );
        }).toList());

    return row;
  }

  List<DataCell> _computeCells(
    List<DataCellProps>? dataCellProps,
    Map<String, dynamic> item,
  ) {
    if (dataCellProps == null) return [];
    List<DataCell> computedCells = [];
    dataCellProps.map(
      (cell) {
        return computedCells.add(DataCell(
          TWidgets(
            layout: cell.child,
            pagePath: pagePath,
            childData: item,
          ),
          placeholder: true,
        ));
      },
    ).toList();

    return computedCells;
  }

  void sort(String columnName, bool ascending) {
    _sortColumn = columnName;
    _sortAscending = ascending;
    refreshDatasource();
  }

  @override
  int get rowCount => tableData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  // void selectAll(bool? checked) {
  //   for (final rowData in tableData) {
  //     rowData["selected"] = checked ?? false;
  //   }
  //   _selectedCount = (checked ?? false) ? tableData.length : 0;
  //   notifyListeners();
  // }

  void dataUpdated(List<dynamic> updatedData) {
    tableData.clear();
    tableData.addAll(updatedData);
    notifyListeners();
  }
}

int _selectedCount = 0;

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}

class SourceRowDataResponse {
  SourceRowDataResponse(this.total, this.data);

  /// THe total ammount of records on the server, e.g. 100
  final int total;

  /// One page, e.g. 10 reocrds
  final List<dynamic> data;
}
