import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_cell_props/data_cell_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/datatable/custom_pagination.dart';
import 'package:the_tool/tool_components/datatable/t_data_row_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/tool_components/t_widgets.dart';
import 'package:data_table_2/data_table_2.dart';

class T_DataTable extends TWidget {
  T_DataTable({
    Key? key,
    required widgetProps,
    required pagePath,
    required widgetUuid,
    childData = const {},
  }) : super(
          key: key,
          widgetProps: widgetProps,
          childData: childData,
          pagePath: pagePath,
          widgetUuid: widgetUuid,
        );

  @override
  State<T_DataTable> createState() => _T_DataTableState();
}

class _T_DataTableState extends TStatefulWidget<T_DataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  T_RowData? _rowDataSource;
  bool _initialized = false;
  PaginatorController? _controller;

  @override
  void initState() {
    if (widget.widgetProps.name == null) {
      throw Exception("Table must have name property to binding data");
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      // _rowDataSource = T_RowData(
      //     context, );

      _controller = PaginatorController();
      _initialized = true;
    }
  }

  @override
  void dispose() {
    _rowDataSource?.dispose();
    super.dispose();
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
            computedColumns.add(DataColumn2(
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

  T_RowData _computeRows(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    var rows = widgetProps?.rows;

    if (rows == null) return T_RowData.empty(context);
    var items = contextData[widgetProps?.name];

    if (items is! List) {
      items = [];
      return T_RowData.empty(context);
    }
    _rowDataSource?.dispose();
    var dataSource = T_RowData(
      context,
      handleSelectRow: _handleSelectRow,
      pagePath: widget.pagePath,
      tableData: items,
      rows: widgetProps!.rows!,
    );
    _rowDataSource = dataSource;
    return dataSource;
  }

  Widget _computeTable(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        PaginatedDataTable2(
          controller: _controller,
          rowsPerPage: _rowsPerPage,
          minWidth: widgetProps?.minWidth,
          sortColumnIndex: 1,
          initialFirstRowIndex: 0,
          onSelectAll: (value) {
            _handleSelectAll(value);
          },
          columns: _computeColumns(widgetProps, contextData),
          source: _computeRows(widgetProps, contextData),
          onRowsPerPageChanged: (value) {
            // No need to wrap into setState, it will be called inside the widget
            // and trigger rebuild
            //setState(() {
            _rowsPerPage = value!;
            print(_rowsPerPage);
            //});
          },
          onPageChanged: (rowIndex) {
            print(rowIndex / _rowsPerPage);
          },
        ),
        //Custom Pagination
        // Positioned(bottom: 16, child: CustomPager(_controller!))
      ],
    );
  }

  void _handleSelectRow(int rowIndex, bool isSelected) {
    var name = widget.widgetProps.name;
    var items = widget.contextData[name];
    if (items == null) return;

    if (items is List) {
      var item = items.elementAt(rowIndex);
      if (item is Map) {
        item["selected"] = isSelected;
        items[rowIndex] = item;
      }
    }

    widget.setPageData({name!: items});
  }

  void _handleSelectAll(bool? value) {
    var name = widget.widgetProps.name;
    var items = widget.contextData[name];
    if (items == null) return;
    _rowDataSource?.selectAll(value);
    if (items is List) {
      items.map((item) {
        if (item is Map) {
          item["selected"] = value;
        }
        return item;
      }).toList();
    }

    widget.setPageData({name!: items});
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
