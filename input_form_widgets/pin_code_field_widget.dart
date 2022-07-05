import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class PinCodeFieldWidget extends StatelessWidget {
  final String keyName;
  final String? labelText;
  final bool isRequired;
  final bool isNumeric;
  final Color? fillColor;
  final int? length;
  final TextInputType keyboardInputType;
  final Function(String?)? onChange;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onCompleted;
  final StreamController<ErrorAnimationType>? errorController;

  const PinCodeFieldWidget({
    Key? key,
    required this.keyName,
    this.errorController,
    this.labelText,
    this.isRequired = true,
    this.isNumeric = false,
    this.fillColor,
    this.onChange,
    this.length,
    this.keyboardInputType = TextInputType.number,
    this.validator,
    this.onCompleted,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FormBuilderField<String>(
      name: keyName,
      onChanged: onChange,
      validator: FormBuilderValidators.compose([
        if (isRequired) FormBuilderValidators.required(context),
        if (isNumeric) FormBuilderValidators.numeric(context),
      ]),
      // initialValue: initialValue,
      builder: (FormFieldState<String> field) {
        return Directionality(
          textDirection: TextDirection.ltr,
          child: PinCodeTextField(
            
            enableActiveFill: true,
            length: length ?? 6,
            keyboardType: keyboardInputType,
            onCompleted: onCompleted,
            validator:
                isNumeric ? FormBuilderValidators.numeric(context) : validator,
            pinTheme: PinTheme(
              shape: PinCodeFieldShape.box,
              borderRadius: BorderRadius.circular(12),
              fieldHeight: 50.h,
              fieldWidth: 50.w,
              borderWidth: 1,

              ///.. before enter value (init)
              //box fill color
              inactiveFillColor: Theme.of(context).inputDecorationTheme.fillColor,
              // box borderColor
              inactiveColor: Theme.of(context).inputDecorationTheme.fillColor,

              ///...current selected
              //box fill color
              selectedFillColor: Theme.of(context).inputDecorationTheme.fillColor,
              // box borderColor
              selectedColor: Colors.green,

              ///...after enter value
              // box border color
              activeColor: Theme.of(context).primaryColor,
              //box fill color
              activeFillColor: Theme.of(context).inputDecorationTheme.fillColor,

              ///... disable color
              // disabledColor: Colors.grey,

              ///... on error
              errorBorderColor: Get.theme.errorColor,
            ),
            autoFocus: false,
            // backgroundColor: fillColor??Theme.of(context).inputDecorationTheme.fillColor,
            appContext: context,
            autoDisposeControllers: true,
            errorAnimationController: errorController,
            // beforeTextPaste: (String paste) {
            //   if (paste?.contains('please join us on room with current info') ??
            //       false) {
            //     paste.split(pattern);
            //   }
            //   return true;
            // },
            onChanged: (value) {
              onChange?.call(value);
              field.didChange(value);
            },
            animationType: AnimationType.fade,
            animationDuration: Duration(microseconds: 300),
          ),
        );
      },
    );
  }
}
