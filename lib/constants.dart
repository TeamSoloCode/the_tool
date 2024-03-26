// ignore_for_file: constant_identifier_names

library constants;

const DefaultDateTimeFormat = "MM/dd/yyyy hh:mm:ss";
const DefaultDateFormat = "MM/dd/yyyy";
const DefaultTimeFormat = "hh:mm:ss";

const CurrencyFieldType = "currency";

/// props of the component that type of TWidget it's gonna compute itself when it's rendering
/// * Ex:
/// ```javascript
/// {
///  type: "container",
///  color: "{{data}}" //-> this need to be computed for the container
///  child: { // -> this child will compute itself when it's rendering
///   type: "text",
///   text: "{{textData}}"
///   color: "{{colorData}}"
///  }
/// }
/// ```
Map<String, bool> ignoredComputeProps = {
  // "className": true, // need to check className to see it has binding value or not
  "suffixIcon": true,
  "prefixIcon": true,
  "head": true,
  "body": true,
  "leading": true,
  "title": true,
  "trailing": true,
  "subtitle": true,
  "child": true,
  "content": true,
  "itemLayout": true,
  "children": true,
  "componentProps": true,
  "computedComponentProps": true,
  "actions": true,
  "separator": true,
  "background": true,
  "secondaryBackground": true,
};

List<String> twidgetHasSizeProps = [
  "container",
  'sized_box',
  "table",
  "clickable",
  'divider',
];
