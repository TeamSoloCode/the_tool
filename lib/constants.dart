// ignore_for_file: constant_identifier_names

library constants;

const DefaultDateTimeFormat = "MM/dd/yyyy hh:mm:ss";
const DefaultDateFormat = "MM/dd/yyyy";
const DefaultTimeFormat = "hh:mm:ss";

const CurrencyFieldType = "currency";

Map<String, bool> ignoredComputeProps = {
  "className": true,
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
