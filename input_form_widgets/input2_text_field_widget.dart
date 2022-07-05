import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';

import '../../utils/shared_style.dart';

class Input2TextFieldWidget extends StatefulWidget {
  final String hintText;
  final String labelText;
  final String keyName;
  final TextInputType textInputType;
  final bool isNumeric;
  final bool isUrl;
  final bool isCreditCard;
  final bool isDate;
  final bool isCvv;
  final bool enabled;
  final bool isEmail;
  final String errorText;
  final bool isRequired;
  final bool isFill;
  final Color? fillColor;
  final Color? containerColor;
  final double containerRadius;
  final Widget? suffixWidget;
  final Widget? icon;
  final Function(String) onChangeFunction;
  // final Color fillColor;
  final int minLine;
  final bool autoFocus;
  final String initialValue;
  final IconData? iconData;
  final TextStyle? style;
  final int? maxLength;
  const Input2TextFieldWidget(
      {Key? key,
      this.hintText = '',
      this.isCreditCard = false,
      this.isDate = false,
      this.labelText = '',
      this.enabled = true,
      required this.errorText,
      this.suffixWidget,
      required this.onChangeFunction,
      required this.keyName,
      this.textInputType = TextInputType.text,
      this.initialValue = '',
      this.isEmail = false,
      this.isCvv = false,
      this.isNumeric = false,
      this.isRequired = true,
      this.isFill = true,
      // this.fillColor,
      this.minLine = 1,
      this.autoFocus = false,
      this.icon,
      this.iconData,
      this.fillColor,
      this.style,
      this.isUrl = false,
      this.containerColor,
      this.containerRadius = 8,
      this.maxLength})
      : super(key: key);

  @override
  _InputTextFieldWidgetState createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<Input2TextFieldWidget> {
  String? text;
  bool isRTL = false;

  @override
  void initState() {
    super.initState();
    text = widget.labelText;
  }

  @override
  Widget build(BuildContext context) {
    return AutoDirection(
      text: text ?? '',
      child: FormBuilderTextField(
        name: widget.keyName,
        style: Get.textTheme.bodyText2,
        minLines: widget.minLine,
        maxLines: widget.minLine,
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        autofocus: widget.autoFocus,
        decoration: SharedStyle.formBuilderWidgetDecoration(
            hint: widget.hintText,
            suffix: widget.suffixWidget,
            icon: widget.icon,
            fillColor: widget.fillColor == null
                ? Get.theme.colorScheme.primary
                : widget.fillColor!,
            borderSide: BorderSide(color: Get.theme.primaryColor)),
        onReset: () {
          setState(() {
            text = widget.hintText;
          });
        },
        validator: FormBuilderValidators.compose([
          if (widget.isRequired)
            FormBuilderValidators.required(context,errorText: widget.errorText),
          if (widget.isEmail)
            FormBuilderValidators.email(context,errorText: widget.errorText),
          if (widget.isNumeric)
            FormBuilderValidators.numeric(context,errorText: widget.errorText),
          if (widget.isUrl)
            FormBuilderValidators.url(context,errorText: widget.errorText),
          if (widget.isCreditCard)
            FormBuilderValidators.creditCard(context,errorText: widget.errorText),
          if (widget.isDate)
            FormBuilderValidators.dateString(context,errorText: widget.errorText),
          if (widget.isCvv)
            FormBuilderValidators.maxLength(context,widget.isCvv ? 3 : 200,
                errorText: widget.errorText),
        ]),
        keyboardType: widget.textInputType,
        onChanged: (str) {
          widget.onChangeFunction(str!);
          if (!mounted) return;
          setState(() {
            text = str;
          });
        },
      ),
    );
  }
}
