import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_cell_props/data_cell_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:data_table_2/data_table_2.dart';

class T_DataTable extends TWidget {
  T_DataTable({
    Key? key,
    required widgetProps,
    required contextData,
    required pagePath,
    required widgetUuid,
  }) : super(
          key: key,
          widgetProps: widgetProps,
          parentData: contextData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_DataTable> createState() => _T_DataTableState();
}

class _T_DataTableState extends TStatefulWidget<T_DataTable> {
  @override
  void initState() {
    super.initState();
  }

  List<DataColumn> _computeColumns(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    if (widgetProps?.columns == null) return [];
    List<DataColumn> computedColumns = [];
    widgetProps?.columns!
        .map(
          (column) => {
            computedColumns.add(DataColumn(
              label: Text(
                column.label,
              ),
              numeric: column.numeric,
              tooltip: column.tooltip,
              onSort: (columnIndex, ascending) {
                var onSort = column.onSort;
                if (onSort != null) {
                  widget.executeJSWithPagePath(
                    "$onSort($columnIndex, $ascending)",
                  );
                }
              },
            ))
          },
        )
        .toList();

    return computedColumns;
  }

  List<DataRow> _computeRows(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    if (widgetProps?.rows == null) return [];
    List<DataRow> computedRows = [];
    widgetProps?.rows!
        .map(
          (row) => {
            computedRows.add(DataRow(
              cells: _computeCells(row.cells, contextData),
            ))
          },
        )
        .toList();

    return computedRows;
  }

  List<DataCell> _computeCells(
    List<DataCellProps>? dataCellProps,
    Map<String, dynamic> contextData,
  ) {
    if (dataCellProps == null) return [];
    List<DataCell> computedCells = [];
    dataCellProps
        .map(
          (cell) => {
            computedCells.add(DataCell(
              TWidgets(
                // key: ValueKey(index),
                layout: cell.child,
                pagePath: widget.pagePath,
                contextData: widget.parentData,
              ),
            ))
          },
        )
        .toList();

    return computedCells;
  }

  Widget _computeTable(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    return DataTable2(
      columns: _computeColumns(widgetProps, contextData),
      rows: _computeRows(widgetProps, contextData),
    );
  }

  @override
  Widget buildWidget(BuildContext context) {
    Widget _snapshot = widget.snapshot;
    LayoutProps? _props = widget.props;

    if (_props != null) {
      _snapshot = _computeTable(_props, widget.contextData);
    }
    return _snapshot;
  }
}
