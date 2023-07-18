import 'dart:async';

import 'package:flutter/material.dart';
import 'package:the_tool/t_widget_interface/data_table_props/data_column_props/data_column_props.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/datatable/t_data_row_widget.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:collection/collection.dart' show DeepCollectionEquality;
import 'package:the_tool/twidget_props.dart';
import 'package:the_tool/page_utils/debouncer.dart';

class TDataTable extends TWidget {
  TDataTable(TWidgetProps twidget) : super(twidget);

  @override
  State<TDataTable> createState() => _TDataTableState();
}

class _TDataTableState extends TStatefulWidget<TDataTable> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  bool _sortAscending = true;
  int? _sortColumnIndex;
  T_RowData? _rowDataSource;
  bool _initialized = false;
  bool _selectAll = false;
  PaginatorController? _paginationController;

  List<dynamic>? prevValue;
  final _updateTableSelectionDebounce = Debouncer(
    delay: const Duration(milliseconds: 200),
  );

  final _sortTableDebounce = Debouncer(
    delay: const Duration(milliseconds: 100),
  );

  @override
  void initState() {
    if (widget.widgetProps.name == null) {
      throw Exception("Table must have \"name\" property to binding data");
    }
    _rowDataSource = _computeRows(widget.widgetProps, widget.getContexData());
    super.initState();
  }

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
    var items = widget.getContexData()[widget.widgetProps.name];

    if (items != null && items?.isNotEmpty) {
      var dataCount =
          widget.getContexData()[widget.widgetProps.total] ?? items.length;
      var tableTable = SourceRowDataResponse(dataCount, items);

      var isTheSameData = false;

      if (items != null && prevValue != null) {
        isTheSameData = _areRecordsEqual(items, prevValue!);
      }

      _rowDataSource?.updateTableData(
        tableTable,
        true,
        isTheSameData,
      );

      _updateTableSelection(items);

      prevValue = items;
    }
  }

  bool _areRecordsEqual(List<dynamic> nextRecords, List<dynamic> prevRecords) {
    if (nextRecords.length != prevRecords.length) {
      return false;
    }

    for (var index = 0; index < nextRecords.length; index++) {
      var prevRecord = prevRecords[index];
      var nextRecord = nextRecords[index];

      String notEqualsKey = nextRecord.keys.firstWhere(
        (key) {
          if (["_selected", "_index"].contains(key)) {
            return false;
          }

          var nextValue = nextRecord[key];
          var prevValue = prevRecord[key];
          return (nextValue is Map && prevValue is Map)
              ? const DeepCollectionEquality().equals(nextValue, prevValue)
              : nextValue != prevValue;
        },
        orElse: () => "",
      );

      if (notEqualsKey.isNotEmpty) {
        return false;
      }
    }

    return true;
  }

  void _updateTableSelection(List<dynamic> data) {
    _updateTableSelectionDebounce.run(() {
      data.asMap().forEach((index, record) {
        var isSelected = record["_selected"] ?? false;

        _rowDataSource?.setSelect(
          ValueKey<dynamic>(record["id"] ?? index),
          isSelected,
        );
      });
    });
    // _rowDataSource?.refreshDatasource();
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
    _sortTableDebounce.run(() {
      var onSort = column.onSort ?? widgetProps?.onSort;
      if (onSort != null) {
        widget.executeJSWithPagePath(
            onSort, [columnIndex, '${column.fieldData}', ascending]);
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
      getContextData: widget.getContexData,
    );

    return dataSource;
  }

  Future<void> _getData(
    int offset,
    int limit,
    String? sortColumn,
    bool? isSortAscending,
  ) async {
    var tableInfo = {
      "offset": offset,
      "limit": limit,
      "sortColumn": sortColumn,
      "isSortAscending": isSortAscending,
    };

    if (widget.widgetProps.loadDataFunction == null) {
      throw Exception("Missing \"loadDataFunction\" property in table widget");
    }

    widget.executeJSWithPagePath(
      widget.widgetProps.loadDataFunction!,
      [tableInfo],
    );
  }

  Widget _computeTable(
    LayoutProps? props,
    Map<String, dynamic> contextData,
  ) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        RepaintBoundary(
          child: AsyncPaginatedDataTable2(
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
              // print(_rowsPerPage);
              //});
            },
            onPageChanged: (rowIndex) {
              // print(rowIndex / _rowsPerPage);
            },
          ),
        ),
        //Custom Pagination
        // Positioned(bottom: 16, child: CustomPager(_controller!))
      ],
    );
  }

  Widget _prepareLoadingWidget(bool onlyUpdateData) {
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
    var items = widget.getContexData()[name];
    if (items == null) return;

    if (items is List) {
      var item = items.elementAt(rowIndex);
      if (item is Map) {
        item["_selected"] = isSelected;
        items[rowIndex] = item;
      }
    }

    widget.setPageData({name!: items});

    final onSelectChanged = widget.props?.onSelectChanged;
    if (onSelectChanged != null) {
      widget.executeJSWithPagePath(onSelectChanged, [rowIndex, isSelected]);
    }
  }

  void _handleSelectAll(bool? selection) {
    var name = widget.widgetProps.name;
    var items = widget.getContexData()[name];
    if (items == null) return;

    if (items is List) {
      items.map((item) {
        if (item is Map) {
          item["_selected"] = selection;
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

    final onSelectAll = widget.props?.onSelectAll;
    if (onSelectAll != null) {
      widget.executeJSWithPagePath(onSelectAll, [selection]);
    }
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? props = widget.props;
    _updateTableSource();

    if (props != null) {
      widget.snapshot = _computeTable(props, widget.getContexData());
    }

    return widget.snapshot;
  }
}
