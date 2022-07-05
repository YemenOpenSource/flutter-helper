import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:lab_app/utils/app_ui_helper/ui_helpers.dart';

class PhoneInputWidget extends StatelessWidget {
  final String keyName;
  final String? labelText;
  final bool isRequired;
  final bool isEnabled;
  final Color? fillColor;
  final Function(String)? onChange;
  final bool showFlag;
  final String? hintText;
  final PhoneNumber? initialValue;
  final TextStyle? textTheme;

  PhoneInputWidget(
      {Key? key,
      required this.keyName,
      this.labelText,
      this.isRequired = true,
      this.isEnabled = true,
      this.fillColor,
      this.hintText,
      this.initialValue,
      this.onChange,
      this.showFlag = true,
      this.textTheme})
      : super(key: key);

  final PhoneNumber phoneNumber = PhoneNumber(isoCode: 'SA');

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Visibility(
          visible: labelText != null,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AutoSizeText(
                labelText ?? '',
                style: Get.textTheme.subtitle2,
              ),
              UiHelper.verticalSpaceSmall,
            ],
          ),
        ),
        FormBuilderField<PhoneNumber>(
          name: keyName,
          validator: FormBuilderValidators.compose([
            if (isRequired) FormBuilderValidators.required(context),
          ]),
          initialValue: initialValue,
          builder: (FormFieldState<PhoneNumber> field) {
            return Theme(
              data: Get.theme.copyWith(
                textTheme: TextTheme(
                  subtitle1: TextStyle(
                    color: Get.theme.primaryColor,
                    // color: AppColors.primaryColor,
                  ),
                  subtitle2: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                  bodyText1: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                  bodyText2: TextStyle(
                    color: Get.theme.primaryColor,
                  ),
                ),
              ),
              child: InternationalPhoneNumberInput(
                countries: ["SA"],
                onInputChanged: (PhoneNumber number) {
                  field.didChange(number);
                  if (onChange != null) {
                    onChange!(number.isoCode!);
                  }
                },

                initialValue: initialValue ?? field.value ?? phoneNumber,

                selectorConfig: SelectorConfig(

                  selectorType: PhoneInputSelectorType.DIALOG,
                  useEmoji: true,
                  // trailingSpace: false,
                  showFlags: showFlag,
                ),
                //ignoreBlank: true,
                autoFocus: false,
                // autoFocusSearch: false,
                isEnabled: isEnabled,
                textStyle: textTheme ?? Get.textTheme.subtitle2,
                selectorTextStyle: textTheme ?? Get.textTheme.subtitle2,
                spaceBetweenSelectorAndTextField: 0.0,
                selectorButtonOnErrorPadding: 16,
                autoValidateMode: AutovalidateMode.disabled,
                formatInput: true,
                keyboardType: TextInputType.numberWithOptions(
                  signed: true,
                  decimal: false,
                ),
                searchBoxDecoration: InputDecoration(
                  isDense: true,
                ),
                inputDecoration: InputDecoration(
                  filled: true,
                  // isDense: true,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 18, horizontal: 12),
                  fillColor:
                      fillColor ?? Get.theme.inputDecorationTheme.fillColor,
                  hintText: hintText ?? labelText,
                  errorText: field.errorText,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(8.0)),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
