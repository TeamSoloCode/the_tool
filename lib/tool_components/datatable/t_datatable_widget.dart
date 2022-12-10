import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/datatable/t_data_row_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
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
  bool _selectAll = false;
  PaginatorController? _paginationController;

  @override
  void initState() {
    if (widget.widgetProps.name == null) {
      throw Exception("Table must have name property to binding data");
    }
    _rowDataSource = _computeRows(widget.widgetProps, widget.contextData);
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var items = widget.contextData[widget.widgetProps.name];

    if (items != null && items?.isNotEmpty) {
      var dataCount =
          widget.contextData[widget.widgetProps.total] ?? items.length;
      var tableTable = SourceRowDataResponse(dataCount, items);
      _rowDataSource?.updateTableData(tableTable, true);
    }

    if (!_initialized) {
      _paginationController = PaginatorController();
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
                // sort<num>(columnIndex, ascending);
                // var onSort = column.onSort ?? widgetProps.onSort;
                // if (onSort != null) {
                //   var code =
                //       "$onSort($columnIndex, '${column.fieldData}', $ascending)";
                //   widget.executeJSWithPagePath(code);
                // }
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

    var dataCount = contextData[widgetProps?.total] ?? items.length;
    var tableTable = SourceRowDataResponse(dataCount, items);

    var dataSource = T_RowData(
      context,
      handleSelectRow: _handleSelectRow,
      pagePath: widget.pagePath,
      tableData: tableTable,
      rows: widgetProps!.rows!,
      getDataFunction: _getData,
    );

    return dataSource;
  }

  Future<void> _getData(
    int offset,
    int limit,
    String? sortColumn,
    bool? isSortAscending,
  ) async {
    var tableInfo = json.encode({
      "offset": offset,
      "limit": limit,
      "sortColumn": sortColumn,
      "isSortAscending": isSortAscending,
    });

    if (widget.widgetProps.loadDataFunction == null) {
      throw Exception("Missing \"loadDataFunction\" property in table widget");
    }

    var jsLoadDataFunction =
        widget.widgetProps.loadDataFunction! + "(JSON.parse('$tableInfo'))";

    widget.executeJSWithPagePath(jsLoadDataFunction);
  }

  Widget _computeTable(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    // _rowDataSource = _computeRows(widgetProps, contextData);

    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AsyncPaginatedDataTable2(
          // key: ValueKey("${_sortAscending}_$_sortColumnIndex"),
          controller: _paginationController,
          rowsPerPage: _rowsPerPage,
          minWidth: widgetProps?.minWidth,
          initialFirstRowIndex: 0,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          columns: _computeColumns(widgetProps, contextData),
          source: _rowDataSource!,
          onSelectAll: (value) {
            _handleSelectAll(value);
          },
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

    if (items is List) {
      items.map((item) {
        if (item is Map) {
          item["selected"] = value;
        }
        return item;
      }).toList();
    }

    widget.setPageData({name!: items});
    _selectAll = !_selectAll;
    if (_selectAll) {
      _rowDataSource?.selectAllOnThePage();
    } else {
      _rowDataSource?.deselectAllOnThePage();
    }
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
