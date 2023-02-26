import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_column_props/data_column_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/datatable/t_data_row_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;

Timer? _debounce;

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
  var debounceDuration = const Duration(milliseconds: 300);

  @override
  void initState() {
    if (widget.widgetProps.name == null) {
      throw Exception("Table must have name property to binding data");
    }
    _rowDataSource = _computeRows(widget.widgetProps, widget.contextData);
    super.initState();
  }

  List<dynamic>? prevValue;
  Timer? _debounce;

  @override
  void didChangeDependencies() {
    if (!_initialized) {
      _paginationController = PaginatorController();
      _initialized = true;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _rowDataSource?.dispose();
    super.dispose();
  }

  void _updateTableSource() {
    var items = widget.contextData[widget.widgetProps.name];

    if (items != null && items?.isNotEmpty) {
      var dataCount =
          widget.contextData[widget.widgetProps.total] ?? items.length;
      var tableTable = SourceRowDataResponse(dataCount, items);

      if (_debounce?.isActive ?? false) _debounce?.cancel();
      _debounce = Timer(const Duration(milliseconds: 100), () {
        _updateTableSelection(items);
      });

      var isTheSameData = false;
      if (items != null && prevValue != null) {
        isTheSameData = _areRecordsEqual(items, prevValue!);
      }

      _rowDataSource?.updateTableData(
        tableTable,
        true,
        isTheSameData,
      );

      prevValue = items;
    }
  }

  bool _areRecordsEqual(List<dynamic> nextRecords, List<dynamic> prevRecords) {
    if (nextRecords.length != prevRecords.length) return false;

    for (var index = 0; index < nextRecords.length; index++) {
      var prevRecord = prevRecords[index];
      var nextRecord = nextRecords[index];

      List keysOfNextRecord = nextRecord.keys.toList();
      List keysOfPrevRecord = prevRecord.keys.toList();

      if (keysOfNextRecord.length != keysOfPrevRecord.length) return false;

      var notEqualsKey = keysOfNextRecord.firstWhere((key) {
        if (["_selected", "_index"].contains(key)) return false;
        var nextValue = nextRecord[key];
        var prevValue = prevRecord[key];
        if (nextValue is Map && prevValue is Map) {
          return const DeepCollectionEquality().equals(
            nextValue,
            prevValue,
          );
        }

        if (nextValue != prevValue) return true;
        return false;
      }, orElse: () => "");

      if (notEqualsKey != "") {
        return false;
      }
    }

    return true;
  }

  void _updateTableSelection(List<dynamic> data) {
    data.asMap().forEach((index, record) {
      var isSelected = record["_selected"];

      if (isSelected is bool) {
        _rowDataSource?.setSelect(
          ValueKey<dynamic>(record["id"] ?? index),
          isSelected,
        );
      }
    });
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
                _sortByColumn(widgetProps, column, columnIndex, ascending);
              },
            ))
          },
        )
        .toList();

    return computedColumns;
  }

  void _sortByColumn(
    LayoutProps? widgetProps,
    DataColumnProps column,
    int columnIndex,
    bool ascending,
  ) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    var onSort = column.onSort ?? widgetProps?.onSort;
    _debounce = Timer(debounceDuration, () {
      if (onSort != null) {
        var code = "$onSort($columnIndex, '${column.fieldData}', $ascending)";
        widget.executeJSWithPagePath(code);
      } else {
        _rowDataSource?.sort(
          column.fieldData ?? columnIndex.toString(),
          ascending,
        );
      }

      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    });
  }

  T_RowData _computeRows(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    var rows = widgetProps?.rows;

    if (rows == null) return T_RowData.empty(context);

    var dataSource = T_RowData(
      context,
      handleSelectRow: _handleSelectRow,
      pagePath: widget.pagePath,
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
    LayoutProps? props,
    Map<String, dynamic> contextData,
  ) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        AsyncPaginatedDataTable2(
          // key: ValueKey("${_sortAscending}_$_sortColumnIndex"),
          controller: _paginationController,
          rowsPerPage: _rowsPerPage,
          minWidth: widget.utils.computeSizeValue(
            props?.minWidth,
            contextData,
          ),
          initialFirstRowIndex: 0,
          sortColumnIndex: _sortColumnIndex,
          sortAscending: _sortAscending,
          sortArrowIcon: Icons.keyboard_arrow_up,
          columns: _computeColumns(props, contextData),
          source: _rowDataSource!,
          // loading: _prepareLoadingWidget(
          //   _rowDataSource?.onlyUpdateData ?? false,
          // ),
          onSelectAll: (value) {
            _handleSelectAll(value);
            _updateTableSource();
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

  Widget _prepareLoadingWidget(bool onlyUpdateData) {
    print("abcd onlyUpdateData ${onlyUpdateData}");
    if (onlyUpdateData) {
      return const Offstage();
    }

    return const Center(
      child: SizedBox(
        width: 64,
        height: 16,
        child: LinearProgressIndicator(),
      ),
    );
  }

  void _handleSelectRow(int rowIndex, bool isSelected) {
    var name = widget.widgetProps.name;
    var items = widget.contextData[name];
    if (items == null) return;

    if (items is List) {
      var item = items.elementAt(rowIndex);
      if (item is Map) {
        item["_selected"] = isSelected;
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
          item["_selected"] = value;
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
    _updateTableSource();

    if (_props != null) {
      _snapshot = _computeTable(_props, widget.contextData);
    }

    return _snapshot;
  }
}
