import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:intl/intl.dart';

class FormBuilderRangeSlider extends FormBuilderField {
  @override
  final String attribute;
  @override
  final FormFieldValidator validator;
  @override
  final RangeValues initialValue;
  @override
  final bool readOnly;
  @override
  final InputDecoration decoration;
  @override
  final ValueChanged onChanged;
  @override
  final ValueTransformer valueTransformer;
  @override
  final FormFieldSetter onSaved;
  final double max;
  final double min;
  final int divisions;
  final Color activeColor;
  final Color inactiveColor;
  final ValueChanged<RangeValues> onChangeStart;
  final ValueChanged<RangeValues> onChangeEnd;
  final RangeLabels labels;
  final RangeSemanticFormatterCallback semanticFormatterCallback;
  final DisplayValues displayValues;
  final TextStyle minTextStyle;
  final TextStyle textStyle;
  final TextStyle maxTextStyle;
  final NumberFormat numberFormat;

  FormBuilderRangeSlider({
    Key key,
    @required this.attribute,
    @required this.min,
    @required this.max,
    @required this.initialValue,
    this.validator,
    this.readOnly = false,
    this.decoration = const InputDecoration(),
    this.divisions,
    this.onChanged,
    this.valueTransformer,
    this.activeColor,
    this.inactiveColor,
    this.onChangeStart,
    this.onChangeEnd,
    this.labels,
    this.semanticFormatterCallback,
    this.onSaved,
    this.displayValues = DisplayValues.all,
    this.minTextStyle,
    this.textStyle,
    this.maxTextStyle,
    this.numberFormat,
  }) : super(
            key: key,
            initialValue: initialValue,
            attribute: attribute,
            validator: validator,
            valueTransformer: valueTransformer,
            onChanged: onChanged,
            readOnly: readOnly,
            builder: (FormFieldState field) {
              final _FormBuilderRangeSliderState state = field;
              var _numberFormat = numberFormat ?? NumberFormat.compact();

              return InputDecorator(
                decoration: decoration.copyWith(
                  enabled: !state.readOnly,
                  errorText: decoration?.errorText ?? field.errorText,
                ),
                child: Container(
                  padding: EdgeInsets.only(top: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RangeSlider(
                        values: field.value,
                        min: min,
                        max: max,
                        divisions: divisions,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                        onChangeEnd: onChangeEnd,
                        onChangeStart: onChangeStart,
                        labels: labels,
                        semanticFormatterCallback: semanticFormatterCallback,
                        onChanged: state.readOnly
                            ? null
                            : (RangeValues values) {
                                field.didChange(values);
                              },
                      ),
                      Row(
                        children: <Widget>[
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.current)
                            Text(
                              '${_numberFormat.format(min)}',
                              style: minTextStyle ?? textStyle,
                            ),
                          Spacer(),
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.minMax)
                            Text(
                              '${_numberFormat.format(field.value.start)} - ${_numberFormat.format(field.value.end)}',
                              style: textStyle,
                            ),
                          Spacer(),
                          if (displayValues != DisplayValues.none &&
                              displayValues != DisplayValues.current)
                            Text(
                              '${_numberFormat.format(max)}',
                              style: maxTextStyle ?? textStyle,
                            ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            });

  @override
  _FormBuilderRangeSliderState createState() => _FormBuilderRangeSliderState();
}

class _FormBuilderRangeSliderState extends FormBuilderFieldState {
  @override
  FormBuilderRangeSlider get widget => super.widget;
}
