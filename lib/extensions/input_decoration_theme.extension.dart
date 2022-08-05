import 'package:flutter/material.dart';

extension InputDecoration on InputDecorationTheme {
  InputDecorationTheme merge(InputDecorationTheme? other) {
    if (other == null) return this;
    return copyWith(
      labelStyle: labelStyle?.merge(other.labelStyle) ?? other.labelStyle,
      floatingLabelStyle: floatingLabelStyle?.merge(other.floatingLabelStyle) ??
          other.floatingLabelStyle,
      helperStyle: helperStyle?.merge(other.helperStyle) ?? other.helperStyle,
      hintStyle: hintStyle?.merge(other.hintStyle) ?? other.hintStyle,
      errorStyle: errorStyle?.merge(other.errorStyle) ?? other.errorStyle,
      prefixStyle: prefixStyle?.merge(other.prefixStyle) ?? other.prefixStyle,
      counterStyle:
          counterStyle?.merge(other.counterStyle) ?? other.counterStyle,
      suffixStyle: suffixStyle?.merge(other.suffixStyle) ?? other.suffixStyle,
      helperMaxLines: other.helperMaxLines ?? helperMaxLines,
      errorMaxLines: other.errorMaxLines ?? errorMaxLines,
      floatingLabelBehavior: other.floatingLabelBehavior,
      floatingLabelAlignment: other.floatingLabelAlignment,
      isDense: other.isDense,
      contentPadding: other.contentPadding ?? contentPadding,
      iconColor: other.iconColor,
      isCollapsed: other.isCollapsed,
      prefixIconColor: other.prefixIconColor ?? prefixIconColor,
      suffixIconColor: other.suffixIconColor ?? suffixIconColor,
      filled: other.filled,
      fillColor: other.fillColor ?? fillColor,
      focusColor: other.focusColor ?? focusColor,
      hoverColor: other.hoverColor ?? hoverColor,
      errorBorder: other.errorBorder ?? errorBorder,
      focusedBorder: other.focusedBorder ?? focusedBorder,
      focusedErrorBorder: other.focusedErrorBorder ?? focusedErrorBorder,
      disabledBorder: other.disabledBorder ?? disabledBorder,
      enabledBorder: other.enabledBorder ?? enabledBorder,
      border: other.border ?? border,
      alignLabelWithHint: other.alignLabelWithHint,
      constraints: other.constraints ?? constraints,
    );
  }
}
