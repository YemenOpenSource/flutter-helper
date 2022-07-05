import 'package:auto_size_text/auto_size_text.dart';
import 'package:lab_app/language_and_localization/app_strings.dart';
import 'package:auto_direction/auto_direction.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:lab_app/utils/app_ui_helper/ui_helpers.dart';
import 'package:get/get.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class PasswordInput extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? confirmLabelText;
  final String? confirmHintText;
  final String keyName;
  final String? attributeKey2;
  final bool isSignUp;
  final int requiredMinLength;
  final bool isFill;
  final EdgeInsetsGeometry? contentPadding;

  // final Color fillColor;

  PasswordInput({
    Key? key,
    required this.hintText,
    this.labelText,
    required this.keyName,
    this.isSignUp = false,
    this.attributeKey2,
    this.requiredMinLength = 6,
    this.isFill = false,
    this.confirmLabelText,
    this.confirmHintText,
    this.contentPadding = const EdgeInsets.all(12.0),
  }) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool isHidden = true;
  String? firstPass;
  String text = '';
  bool isRTL = false;

  @override
  void initState() {
    super.initState();
    text = widget.hintText;
  }

  @override
  Widget build(BuildContext context) {
    if (widget.isSignUp) {
      return Column(
        children: <Widget>[
          buildTextFormField(),
          SizedBox(
            height: 15.0,
          ),
          buildConfirmPassword(),
        ],
      );
    } else {
      return buildTextFormField();
    }
  }

  Widget buildConfirmPassword() {
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
                widget.labelText ?? '',
                style: Get.textTheme.subtitle2!.copyWith(
                  color: Get.theme.primaryColor,
                ),
              ),
              UiHelper.verticalSpaceSmall,
            ],
          ),
        ),
        AutoDirection(
          text: text,
          child: FormBuilderTextField(
            name: widget.attributeKey2 ?? '',
            keyboardType: TextInputType.text,
            obscureText: isHidden,
            maxLines: 1,
            style: Get.textTheme.subtitle2,
            initialValue: '',
            decoration: InputDecoration(
              // labelText: widget.labelText,
              hintText: widget.confirmHintText ??
                  AppStrings.passwordConfirmHint.tr.capitalizeFirst,
              filled: widget.isFill,
              contentPadding: widget.contentPadding,
              suffixIcon: IconButton(
                onPressed: _toggleVisibility,
                icon: isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              // prefixIcon: Icon(Icons.lock),
              prefixIcon: Container(
                margin: EdgeInsetsDirectional.only(end: 4.0),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadiusDirectional.only(
                    // bottomEnd: Radius.circular(10),
                    // topEnd: Radius.circular(10),
                    bottomStart: Radius.circular(8.0),
                    topStart: Radius.circular(8.0),
                  ),
                ),
                child: Icon(
                  Icons.lock,
                  color: Get.theme.iconTheme.color,
                ),
              ),
              isDense: true,
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8.0)),
                  borderSide: BorderSide(
                      // color: Get.textTheme.caption!.color!,
                      )
                  // borderSide: BorderSide.none,
                  ),
            ),
            autofocus: false,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context,widget.requiredMinLength),
              (val) {
                if (val == firstPass) {
                  return null;
                } else {
                  return 'Not Match Passwords';
                }
              },
            ]),
            onChanged: (str) {
              if (!mounted) return;
              setState(() {
                text = str!;
              });
            },
          ),
        ),
      ],
    );
  }

  Widget buildTextFormField() {
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
                widget.labelText ?? '',
                style: Get.textTheme.subtitle2!.copyWith(
                  color: Get.theme.primaryColor,
                ),
              ),
              UiHelper.verticalSpaceSmall,
            ],
          ),
        ),
        AutoDirection(
          text: text,
          child: FormBuilderTextField(
            name: widget.keyName,
            initialValue: '',
            style: Get.textTheme.subtitle2,
            keyboardType: TextInputType.text,
            autofocus: false,
            obscureText: isHidden,
            onChanged: (pass1) {
              firstPass = pass1;
              setState(() {
                text = pass1!;
              });
            },
            decoration: InputDecoration(
              hintText: widget.hintText,
              // labelText: widget.labelText,
              contentPadding: widget.contentPadding,
              // fillColor: widget.fillColor,
              suffixIcon: IconButton(
                onPressed: _toggleVisibility,
                icon: isHidden
                    ? Icon(Icons.visibility_off)
                    : Icon(Icons.visibility),
              ),
              prefixIcon: Container(
                margin: EdgeInsetsDirectional.only(end: 4.0),
                padding: EdgeInsets.symmetric(vertical: 16.0),
                decoration: BoxDecoration(
                  color: Get.theme.primaryColor,
                  borderRadius: BorderRadiusDirectional.only(
                    // bottomEnd: Radius.circular(10),
                    // topEnd: Radius.circular(10),
                    bottomStart: Radius.circular(8.0),
                    topStart: Radius.circular(8.0),
                  ),
                ),
                child: Icon(
                  Icons.lock,
                  color: Get.theme.iconTheme.color,
                ),
              ),
              filled: widget.isFill,
              isDense: true,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0)),
                // borderSide: BorderSide.none,
              ),
            ),
            maxLines: 1,
            validator: FormBuilderValidators.compose([
              FormBuilderValidators.required(context),
              FormBuilderValidators.minLength(context,widget.requiredMinLength),
            ]),
          ),
        ),
      ],
    );
  }

  void _toggleVisibility() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  void dispose() {
    super.dispose();
  }
}
