import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:the_tool/t_widget_interface/layout_content/layout_props.dart';
import 'package:the_tool/tool_components/mixin_component/field_mixin.dart';
import 'package:the_tool/tool_components/t_widget.dart';
import 'package:the_tool/twidget_props.dart';

class TMultiSelectField extends TWidget {
  TMultiSelectField(TWidgetProps tWidget) : super(tWidget);

  @override
  TStatefulWidget<TMultiSelectField> createState() => _TMultiSelectFieldState();
}

class _TMultiSelectFieldState extends TStatefulWidget<TMultiSelectField>
    with FieldMixin {
  String? _errorMessage = null;
  List<String> _selectedValues = [];
  List<String> _listItems = [];

  late FormFieldState<dynamic> _field;

  GlobalKey<DropdownSearchState<String>> _dropdownSearchKey = GlobalKey<DropdownSearchState<String>>();

  @override
  void initState() {
    _listItems = [];
    _selectedValues = [];
    super.initState();
  }

  Widget _computeMultiSelectField(
    LayoutProps? widgetProps,
    Map<String, dynamic> contextData,
  ) {
    String? name = widgetProps?.name;
    var value = contextData[name];
    // items = widgetProps?.items ?? [];
    assert(name != null, "Missing \"name\" in field widget");

    // _dropDownKey.currentState?.setValue(value);
    return FormBuilderField(
      name: name!,
      // key: _dropdownSearchKey,
      builder: (FormFieldState<Object> field) {
        return InputDecorator( decoration: computeFieldDecoration(
          widgetProps,
          thisWidget: widget,

          errorMessage: field.errorText ?? _errorMessage,

        ),
        child: _multiSelect(widgetProps!, field));
      },

      enabled: widgetProps?.enabled ?? true,
      onChanged: _onChangeOption,
      initialValue: widget.props?.defaultValue ?? value,
      validator: FormBuilderValidators.compose([
        ...computeFieldValidators(widget.props, contextData),
        (dynamic value) {
          _runValidationFunction();
          return null;
        }
      ]),

      onSaved: (dynamic value) {
        _runValidationFunction();
      },
    );
  }


   Widget _multiSelect(LayoutProps props,FormFieldState<Object> field)  {
     _field = field;
      List<dynamic> items = [];
      if(props.items == null || (props.items as List).isEmpty) {
        items = [];
      } else {
        if(  props.items[0] is! List ) {
          items = List.from(props.items ?? []).cast<String>();
        } else {
          items = List.from(props.items ?? []).cast<List>();
        }
      }

     return DropdownSearch<dynamic>.multiSelection(
       asyncItems: (values) {
         return getData(values,items);
       },

       itemAsString: (item) {
         if(item is! List) {
           return item;
         }
         if(item.length < 2) {
           throw Exception ('If option is a list , It must have at least 2 items');
         }
         return item[1];
       },


       key: _dropdownSearchKey,
       // popupProps: PopupPropsMultiSelection.menu(
       //   showSelectedItems: true,
       //
       // ),

       onChanged: (List<dynamic>? value) {
         field.didChange(value);
       },
       // on: (List<String>? values) {
       //   String name = widget.widgetProps.name ?? "";
       //   widget.setPageData({name: values});
       //
       //   final onResponse = widget.widgetProps.onChange;
       //   if (onResponse != null) {
       //     final responseData = values;
       //     widget.executeJSWithPagePath(onResponse, (responseData ?? []).cast<String>());
       //   }
       // },
     );
   }

  Future<List<dynamic>> getData(_,List<dynamic> items) async {


    return items ;
  }

   Widget _singleSelect(FormFieldState<Object> field) {
     _field = field;
     return DropdownSearch<String>(
       popupProps: PopupProps.menu(
         showSelectedItems: true,
         disabledItemFn: (String s) => s.startsWith('I'),
       ),
       items: _listItems,

       onChanged: print,
       selectedItem: "Brazil",
     );
   }
  @override
  void didChangeDependencies() {
    // var itemDelected - widget.widgetProps.on
    String? name = widget.widgetProps.name;
    // var listItems = widget.widgetProps.items;
    dynamic currentValue = _dropdownSearchKey.currentState?.getSelectedItems;

    List<dynamic> listDataFromServer = widget.getContexData()[name];

    // Selected value để add vào multiSelected field không được là List<dynamic>
    _selectedValues = listDataFromServer.cast<String>();
    if (_selectedValues != currentValue && name != null) {
      Future.delayed(Duration.zero, () async {
        /**
         * nếu selectedValues là List<dyanmic> thì hàm dưới này sẽ không chạy được
         */
        _dropdownSearchKey.currentState?.changeSelectedItems(_selectedValues!);
        //
        _dropdownSearchKey.currentState?.setState(() {});
        // _field.didChange(selectedValues);
      });
    }

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _dropdownSearchKey.currentState?.dispose();
    super.dispose();
  }

  void _onChangeOption(dynamic value) {
    String name = widget.widgetProps.name ?? "";
    widget.setPageData({name: value});
    _selectedValues = value;
  }

  void _runValidationFunction() async {
    setState(() {
      _errorMessage =
          "checking..."; // this to prevent form validate pass the field before it validated;
    });
    String? errorMessage = await runValidationFunction(thisWidget: widget);
    setState(() {
      _errorMessage = errorMessage;
    });
  }

  @override
  Widget buildWidget(BuildContext context) {
    LayoutProps? props = widget.props;

    if (props != null) {
      var test = props.items;
      widget.snapshot = _computeMultiSelectField(props, widget.getContexData());
    }
    return widget.snapshot;
  }
}
