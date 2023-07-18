import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_cell_props/data_cell_props.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_row_props/data_row_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_RowData extends AsyncDataTableSource {
  final BuildContext context;
  late List<DataRowProps> rows;

  late Function(int rowIndex, bool isSelected) handleSelectRow;
  late String pagePath;
  late Future<void> Function(int, int, String?, bool?) getDataFunction;
  late Map<String, dynamic> Function() getContextData;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  SourceRowDataResponse tableData = SourceRowDataResponse(0, []);

  int? _errorCounter;
  String? _sortColumn;
  bool? _sortAscending;
  bool _onlyUpdateData = false;

  T_RowData(
    this.context, {
    required this.rows,
    required this.pagePath,
    required this.getDataFunction,
    required this.handleSelectRow,
    required this.getContextData,
    this.hasRowTaps = false,
    this.hasRowHeightOverrides = false,
    this.hasZebraStripes = false,
  });

  T_RowData.empty(this.context) {
    tableData = SourceRowDataResponse(0, []);
  }

  @override
  Future<AsyncRowsResponse> getRows(int start, int end) async {
    if (_errorCounter != null) {
      _errorCounter = _errorCounter! + 1;

      if (_errorCounter! % 2 == 1) {
        await Future.delayed(const Duration(milliseconds: 1000));
        throw 'Error #${((_errorCounter! - 1) / 2).round() + 1} has occured';
      }
    }

    assert(start >= 0);
    !_onlyUpdateData
        ? getDataFunction(start, end, _sortColumn, _sortAscending)
        : _onlyUpdateData = false;

    var index = 0;
    var row = AsyncRowsResponse(
        tableData.total,
        tableData.data.map((rowData) {
          rowData["_index"] = index;
          ++index;
          final isSelected = rowData["_selected"] ?? false;
          final rowKey = ValueKey<dynamic>(rowData["id"] ?? index);

          return DataRow(
            key: rowKey,
            selected: isSelected,
            onSelectChanged: (value) {
              if (value == null) return;
              final selectedIndex = rowData["_index"];

              setSelect(
                ValueKey<dynamic>(rowData["id"] ?? selectedIndex),
                value,
              );

              handleSelectRow(selectedIndex, value);
            },
            cells: _computeCells(
              rows[0].cells,
              Map<String, dynamic>.from(rowData),
            ),
          );
        }).toList());

    return row;
  }

  void setSelect(LocalKey rowKey, bool selected) {
    setRowSelection(rowKey, selected);
  }

  List<DataCell> _computeCells(
    List<DataCellProps>? dataCellProps,
    Map<String, dynamic> rowData,
  ) {
    if (dataCellProps == null) return [];
    final childData = rowData;
    childData[UtilsManager.parentPrefix] = getContextData();

    List<DataCell> computedCells = [];
    dataCellProps.map(
      (cell) {
        return computedCells.add(DataCell(
          TWidgets(
            layout: cell.child,
            pagePath: pagePath,
            childData: childData,
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
  int get rowCount => tableData.total;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  bool get onlyUpdateData => _onlyUpdateData;

  void updateTableData(
    SourceRowDataResponse sourceRow,
    bool onlyUpdateData,
    bool isTheSamedata,
  ) {
    tableData = sourceRow;

    if (!isTheSamedata) {
      _onlyUpdateData = onlyUpdateData;
      refreshDatasource();
    }
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
