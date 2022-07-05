import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:lab_app/utils/app_ui_helper/ui_helpers.dart';

class DateTimePickerWidget extends StatelessWidget {
  final String keyName;
  final String? labelText;
  final bool? isFill;
  final Color? fillColor;
  final bool isRequired;
  final InputType inputType;
  final DateFormat? dateFormat;
  final DateTime? firstDate;
  final DateTime? lastDate;
  final DateTime? initialValue;
  final InputBorder? inputBorder;
  final Function(DateTime?)? onChange;
  final Widget? prefixIcon;

  DateTimePickerWidget(
      {Key? key,
      required this.keyName,
      this.labelText,
      this.isFill = true,
      this.fillColor,
      this.isRequired = true,
      this.inputType = InputType.date,
      this.firstDate,
      this.lastDate,
      this.dateFormat,
      this.initialValue,
      this.inputBorder,
      this.onChange,
      this.prefixIcon})
      : super(key: key);

  bool get setInit {
    if (initialValue != null && lastDate != null) {
      return initialValue!.isBefore(lastDate!);
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (labelText != null)
          AutoSizeText(
            labelText!,
            style: Get.textTheme.subtitle1?.copyWith(
              color: Get.theme.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        UiHelper.verticalSpaceTiny,
        Theme(
          data: Get.theme.copyWith(
            colorScheme: ColorScheme.light(primary: Get.theme.primaryColor),
          ),
          child: FormBuilderDateTimePicker(
            name: keyName,
            inputType: inputType,
            initialValue: initialValue,
            style: Get.textTheme.subtitle2!
                .copyWith(color: Get.theme.primaryColor),
            firstDate: firstDate,
            initialDate: lastDate,
            lastDate: lastDate,
            onChanged: onChange,
            cursorColor: Get.theme.primaryColor,
            format: dateFormat ?? DateFormat('dd-MM-yyyy hh:mm'),
            validator: FormBuilderValidators.compose([
              if (isRequired) FormBuilderValidators.required(context),
            ]),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(
                vertical: 16,
                horizontal: 10,
              ),
              filled: isFill,
              fillColor: fillColor,
              // labelText: labelText,
              // suffixIcon: Icon(Icons.calendar_today_outlined),
              // prefix: Icon(Icons.calendar_today_outlined),
              prefixIcon: prefixIcon,
              hintText: 'dd/MM/yyyy',
              border: inputBorder ??
                  OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
            ),
          ),
        ),
      ],
    );
  }
}
