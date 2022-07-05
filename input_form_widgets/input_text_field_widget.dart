import 'package:auto_direction/auto_direction.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lab_app/utils/app_ui_helper/ui_helpers.dart';
import 'package:get/get.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class InputTextFieldWidget extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final String keyName;
  final TextInputType? textInputType;
  final bool isNumeric;
  final bool isUrl;
  final bool enabled;
  final bool isEmail;
  final bool isRequired;
  final bool isFill;
  final Function(String)? onChange;
  final InputBorder? inputBorder;
  final int? maxLength;
  final int? minLine;
  final int? maxLines;
  final bool? autoFocus;
  final String? initialValue;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final double? prefixIconSize;
  final Color? prefixIconColor;
  final Widget? suffixIcon;
  final Color? fillColor;
  final TextStyle? style;
  final TextStyle? hintStyle;
  final EdgeInsetsGeometry? contentPadding;
  final List<TextInputFormatter>? inputFormatters;

  const InputTextFieldWidget(
      {Key? key,
      this.hintText,
      this.labelText,
      this.enabled = true,
      required this.keyName,
      this.textInputType,
      this.initialValue,
      this.isEmail = false,
      this.isNumeric = false,
      this.isRequired = true,
      this.isUrl = false,
      this.isFill = true,
      // this.fillColor,
      this.minLine,
      this.autoFocus = false,
      this.prefixIcon,
      this.style,
      this.hintStyle,
      this.onChange,
      this.inputBorder,
      this.suffixIcon,
      this.maxLength,
      this.inputFormatters,
      this.maxLines,
      this.fillColor,
      this.contentPadding =
          const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
      this.prefixIconSize,
      this.prefixIconColor,
      this.prefix,
      this.suffix})
      : super(key: key);

  @override
  _InputTextFieldWidgetState createState() => _InputTextFieldWidgetState();
}

class _InputTextFieldWidgetState extends State<InputTextFieldWidget> {
  late String text;
  bool isRTL = false;

  @override
  void initState() {
    super.initState();
    text = widget.hintText ?? widget.labelText ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: widget.labelText != null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                widget.labelText ?? 'none',
                style: Get.textTheme.subtitle2!.copyWith(
                  color: Get.theme.primaryColor,
                ),
              ),
              UiHelper.verticalSpaceSmall,
            ],
          ),
        ),
        AutoDirection(
          text: "Amjad",
          onDirectionChange: (bool change) {},
          child: FormBuilderTextField(
            name: widget.keyName,
            style: widget.style ?? Get.textTheme.subtitle2,
            minLines: widget.minLine,
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            enabled: widget.enabled,
            initialValue: widget.initialValue,
            autofocus: widget.autoFocus!,
            // textAlignVertical: TextAlignVertical.bottom,
            decoration: InputDecoration(
              // suffixIcon:widget.suffixIcon ,
              //  prefix: ,
              suffixIcon: widget.suffixIcon,
              prefix: widget.prefix,
              suffix: widget.suffix,
              contentPadding: widget.contentPadding,
              hintText: widget.hintText,
              hintStyle: widget.hintStyle ?? Get.textTheme.caption,
              alignLabelWithHint: true,
              fillColor:
                  widget.fillColor ?? Get.theme.inputDecorationTheme.fillColor,
              filled: widget.isFill,
              // suffixIcon: widget.suffixIcon,
              prefixIcon: widget.prefixIcon,
              isDense: true,
              border: widget.inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(
                        12.0,
                      ),
                    ),
                    // borderSide: BorderSide(
                    //     // color: Get.textTheme.caption!.color!,
                    //     ),
                    borderSide: BorderSide.none,
                  ),
            ),
            inputFormatters: widget.inputFormatters ?? getEmailInputFormatter(),
            onReset: () {
              setState(() {
                text = widget.labelText ?? widget.hintText ?? '';
              });
            },
            validator: FormBuilderValidators.compose([
              if (widget.isRequired) FormBuilderValidators.required(context),
              if (widget.isEmail) FormBuilderValidators.email(context),
              if (widget.isNumeric) FormBuilderValidators.numeric(context),
              if (widget.isUrl) FormBuilderValidators.url(context),
            ]),
            keyboardType: getKeyboardType(),
            onChanged: (str) {
              if (!mounted) return;
              setState(() {
                text = str!;
              });
              if (widget.onChange != null) {
                widget.onChange!.call(str!);
              }
            },
          ),
        ),
      ],
    );
  }

  TextInputType? getKeyboardType() {
    if (widget.textInputType != null) {
      return widget.textInputType;
    } else {
      return (widget.minLine != null && widget.minLine! >= 7)
          ? TextInputType.multiline
          : TextInputType.text;
    }
  }

  List<TextInputFormatter>? getEmailInputFormatter() {
    return widget.isEmail
        ? [
            FilteringTextInputFormatter.deny(
              RegExp('[ ]'),
            )
          ]
        : null;
  }
}
