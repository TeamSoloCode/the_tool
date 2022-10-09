import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_cell_props/data_cell_props.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_row_props/data_row_props.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:the_tool/utils.dart';

class T_RowData extends DataTableSource {
  final BuildContext context;
  late List<DataRowProps> rows;
  late List<dynamic> tableData;
  late Function(int rowIndex, bool isSelected) handleSelectRow;
  late String pagePath;
  // Add row tap handlers and show snackbar
  bool hasRowTaps = false;
  // Override height values for certain rows
  bool hasRowHeightOverrides = false;
  // Color each Row by index's parity
  bool hasZebraStripes = false;

  T_RowData(
    this.context, {
    required this.rows,
    required this.tableData,
    required this.pagePath,
    required this.handleSelectRow,
    sortedByCalories = false,
    this.hasRowTaps = false,
    this.hasRowHeightOverrides = false,
    this.hasZebraStripes = false,
  }) {
    void sort<T>(
        Comparable<T> Function(DataRowProps d) getField, bool ascending) {
      tableData.sort((a, b) {
        final aValue = getField(a);
        final bValue = getField(b);
        return ascending
            ? Comparable.compare(aValue, bValue)
            : Comparable.compare(bValue, aValue);
      });

      notifyListeners();
    }

    if (sortedByCalories) {
      // sort((d) => d.calories, true);
    }
  }

  T_RowData.empty(this.context) {
    tableData = [];
  }

  @override
  DataRow? getRow(int index) {
    final format = NumberFormat.decimalPercentPattern(
      locale: 'en',
      decimalDigits: 0,
    );
    assert(index >= 0);
    if (index >= tableData.length) throw 'index > _desserts.length';
    final rowData = tableData[index];
    return DataRow2.byIndex(
      index: index,
      selected: UtilsManager.isTruthy(rowData["selected"]),
      // color: color != null
      //     ? MaterialStateProperty.all(color)
      //     : (hasZebraStripes && index.isEven
      //         ? MaterialStateProperty.all(Theme.of(context).highlightColor)
      //         : null),
      onSelectChanged: (value) {
        if (UtilsManager.isTruthy(rowData["selected"]) != value) {
          _selectedCount += value! ? 1 : -1;
          assert(_selectedCount >= 0);
          // rowData["selected"].selected = value;
          handleSelectRow(index, value);
          notifyListeners();
        }
      },
      onTap: hasRowTaps ? () => _showSnackbar(context, 'Tapped on row') : null,
      onDoubleTap: hasRowTaps
          ? () => _showSnackbar(context, 'Double Tapped on row')
          : null,
      onLongPress: hasRowTaps
          ? () => _showSnackbar(context, 'Long pressed on row')
          : null,
      onSecondaryTap: hasRowTaps
          ? () => _showSnackbar(context, 'Right clicked on row')
          : null,
      onSecondaryTapDown: hasRowTaps
          ? (d) => _showSnackbar(context, 'Right button down on row')
          : null,
      // specificRowHeight:
      //     hasRowHeightOverrides && dessert.fat >= 25 ? 100 : null,
      cells: _computeCells(rows[0].cells, tableData[index]),
    );
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

  @override
  int get rowCount => tableData.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

int _selectedCount = 0;

_showSnackbar(BuildContext context, String text, [Color? color]) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: color,
    duration: const Duration(seconds: 1),
    content: Text(text),
  ));
}
