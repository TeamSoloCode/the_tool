import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
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
  }) {}

  T_RowData.empty(this.context) {
    tableData = [];
  }

  @override
  Future<AsyncRowsResponse> getRows(int offset, int limit) async {
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    assert(offset >= 0);

    // List returned will be empty is there're fewer items than startingAt
    var tableData = await getDataFunction(
      offset,
      limit,
      _sortColumn,
      _sortAscending,
    );

    var index = 0;
    var row = AsyncRowsResponse(
        tableData.total,
        tableData.data.map((rowData) {
          ++index;
          return DataRow(
            key: ValueKey<dynamic>(rowData["id"] ?? index),
            selected: rowData["selected"] ?? false,
            onSelectChanged: (value) {
              if (value != null) {
                setRowSelection(
                  ValueKey<dynamic>(rowData["id"] ?? index),
                  value,
                );

                handleSelectRow(index, value);
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
