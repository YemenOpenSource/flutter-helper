import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:lab_app/data/app_enums/app_enums.dart';
import 'package:lab_app/language_and_localization/app_strings.dart';
import 'package:lab_app/utils/app_ui_helper/ui_helpers.dart';
import 'package:toggle_switch/toggle_switch.dart';

class GenderSelectorFromWidget extends StatelessWidget {
  final bool isRequired;
  final String keyName;

  final ValueChanged<Gender?>? onChange;
  final Color? fillColor;

  final Gender? initialValue;

  const GenderSelectorFromWidget({
    Key? key,
    this.isRequired = true,
    required this.keyName,
    this.onChange,
    this.fillColor,
    this.initialValue,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<Gender>(
      name: keyName,
      onChanged: onChange,
      initialValue: initialValue ?? Gender.male,
      validator: FormBuilderValidators.compose([
        if (isRequired) FormBuilderValidators.required(context),
      ]),
      builder: (FormFieldState<Gender> field) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ToggleSwitch(
              minWidth: Get.width / 2.5,
              initialLabelIndex: field.value == null
                  ? 0
                  : field.value == Gender.male
                      ? 0
                      : 1,
              cornerRadius: 8.0,
              animate: true,
              radiusStyle: true,
              activeFgColor: Colors.white,
              inactiveBgColor: Colors.white,
              inactiveFgColor: Get.theme.primaryColor,
              totalSwitches: 2,
              labels: [
                LabAppStrings.male.tr.capitalizeFirst!,
                LabAppStrings.female.tr.capitalizeFirst!
              ],
              icons: [FontAwesomeIcons.mars, FontAwesomeIcons.venus],
              activeBgColors: [
                [Get.theme.primaryColor],
                [Get.theme.primaryColor]
              ],
              onToggle: (index) {
                if (index == 0) {
                  field.didChange(Gender.male);
                } else {
                  field.didChange(Gender.female);
                }
              },
            ),
            if (field.errorText != null) ...[
              UiHelper.verticalSpaceTiny,
              Text(
                field.errorText!,
                textAlign: TextAlign.start,
                style: Get.textTheme.caption?.copyWith(
                  color: Get.theme.errorColor,
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
