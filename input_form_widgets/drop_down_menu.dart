// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:get/get.dart';
//
// import '../../../common/shared/ui_helpers.dart';
//
// class DropDownMenu extends StatelessWidget {
//   final List<String> list;
//   final String kfHeaderTitle;
//   final String keyName;
//   final String labelText;
//   final String hintText;
//   final Function onChange;
//   final bool isFirst;
//   final bool isLast;
//
//   const DropDownMenu({
//     this.list,
//     this.kfHeaderTitle,
//     this.keyName,
//     this.labelText,
//     this.hintText,
//     this.onChange,
//     this.isFirst,
//     this.isLast,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.only( left: 20, right: 20),
//       // margin: EdgeInsets.only(
//       //     left: 0.0, right: 0.0, top: topMargin, bottom: bottomMargin),
//       decoration: BoxDecoration(
//           color: Get.theme.primaryColor,
//           borderRadius: buildBorderRadius,
//           boxShadow: [
//             BoxShadow(
//                 color: Get.theme.focusColor.withOpacity(0.1),
//                 blurRadius: 10,
//                 offset: Offset(0, 5)),
//           ],
//           border: Border.all(color: Get.theme.focusColor.withOpacity(0.05))),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Visibility(
//             visible: labelText != null,
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: AutoSizeText(
//                 labelText ?? '',
//                 style: Get.textTheme.bodyText1,
//               ),
//             ),
//           ),
//           Visibility(
//               visible: labelText != null, child: UiHelper.verticalSpaceSmall),
//           FormBuilderDropdown(
//             name: keyName,
//             onChanged: onChange,
//             decoration: InputDecoration(
//               //labelText: labelText,
//               //labelStyle: kAppBarTextStyle,
//               contentPadding: EdgeInsets.all(10),
//               filled: true,
//               fillColor: Colors.white,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.all(Radius.circular(10.0)),
//                 borderSide: BorderSide.none,
//               ),
//               // enabledBorder: OutlineInputBorder(
//               //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               //   borderSide: BorderSide(
//               //     color: Colors.grey, //Theme.of(context).primaryColor,
//               //     //width: 1.5,
//               //   ),
//               // ),
//               // focusedBorder: OutlineInputBorder(
//               //   borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
//               //   borderRadius: BorderRadius.all(Radius.circular(10.0)),
//               // ),
//             ),
//             // initialValue: 'Male',
//             hint: Text(hintText),
//             validator: FormBuilderValidators.compose(
//                 [FormBuilderValidators.required(context)]),
//             items: list
//                 .map((zone) =>
//                     DropdownMenuItem(value: zone, child: Text("$zone")))
//                 .toList(),
//           ),
//         ],
//       ),
//     );
//   }
//
//   double get topMargin {
//     if ((isFirst != null && isFirst)) {
//       return 20;
//     } else if (isFirst == null) {
//       return 20;
//     } else {
//       return 0;
//     }
//   }
//
//   double get bottomMargin {
//     if ((isLast != null && isLast)) {
//       return 10;
//     } else if (isLast == null) {
//       return 10;
//     } else {
//       return 0;
//     }
//   }
//
//   BorderRadius get buildBorderRadius {
//     if (isFirst != null && isFirst) {
//       return BorderRadius.vertical(top: Radius.circular(10));
//     }
//     if (isLast != null && isLast) {
//       return BorderRadius.vertical(bottom: Radius.circular(10));
//     }
//     if (isFirst != null && !isFirst && isLast != null && !isLast) {
//       return BorderRadius.all(Radius.circular(0));
//     }
//     return BorderRadius.all(Radius.circular(10));
//   }
// }
import 'package:auto_size_text/auto_size_text.dart';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import '../../utils/shared_style.dart';

class DropDownMenu extends StatelessWidget {
  final List<String> list;
  final String kfHeaderTitle;
  final String keyName;
  final String labelText;
  final String hintText;
  final Color? fillColor;
  final Function onChange;
  final bool isFirst;
  final bool isLast;
  final bool active;
  final Widget? suffixIcon;

  DropDownMenu(
      {Key? key,
      this.list = const [''],
      this.kfHeaderTitle = '',
      required this.keyName,
      this.labelText = '',
      this.hintText = '',
      required this.onChange,
      this.isFirst = false,
      this.isLast = false,
      this.fillColor,
      this.active = true,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20),
      decoration:
          SharedStyle.containerBoxDecoration(radius: 8, color: fillColor),
      child: FormBuilderDropdown(
        elevation: 5,
        // initialValue: 'intiValue',
        disabledHint: Text('intiValue'),
        dropdownColor: Get.theme.primaryColor.withOpacity(0.9),
        icon: Icon(Icons.keyboard_arrow_down, color: Get.theme.primaryColor),
        // SvgPicture.asset(
        //     AppImages.arrow_down
        // ),
        name: keyName,
        onChanged: (value) => onChange(value),
        decoration: SharedStyle.getInputDecoration(
          suffixIcon: suffixIcon,
        ),

        hint: AutoSizeText(
          hintText,
          style: Get.textTheme.bodyText1,
        ),
        validator:
            FormBuilderValidators.compose([FormBuilderValidators.required(context)]),
        items: list
            .map((zone) => DropdownMenuItem(
                  value: zone,
                  child: Container(
                      decoration: SharedStyle.containerBoxDecoration(radius: 8),
                      child: Text(
                        "${zone.tr.capitalizeFirst}",
                        style: Get.textTheme.bodyText1,
                      )),
                ))
            .toList(),
        style: Get.textTheme.bodyText1,
      ),
      /*
      *  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: labelText != null,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AutoSizeText(
                labelText ?? '',
                style: Get.textTheme.bodyText1
                    .copyWith(color: active ? Colors.black : Colors.black26),
              ),
            ),
          ),
          Visibility(
              visible: labelText != null, child: UiHelper.vertical8),
          IgnorePointer(
            ignoring: !active,
            child: FormBuilderDropdown(
              elevation: 5,
              // initialValue: 'intiValue',
              disabledHint: Text('intiValue'),
              dropdownColor: Get.theme.colorScheme.primary,
              icon: SvgPicture.asset(
                  AppImages.arrow_down
              ),
              name: keyName,
              onChanged: (value) =>onChange!=null? onChange(value):null,
              decoration: SharedStyle.getInputDecoration(
                suffixIcon: suffixIcon,
              ),

              hint: Padding(
                padding: const EdgeInsets.only(right: 8,left: 8),
                child: AutoSizeText(
                  hintText,
                  style: Get.textTheme.bodyText1,
                ),
              ),
              validator: FormBuilderValidators.compose(
                  [FormBuilderValidators.required(context)]),
              items: list
                  .map((zone) =>
                  DropdownMenuItem(
                      value: zone, child: Container(
                     //clipBehavior: Clip.antiAlias,
                       decoration: SharedStyle.containerBoxDecoration(),
                      child: Text("${zone.tr}",style: Get.textTheme.bodyText1,)),
                  ))
                  .toList(),
              style: Get.textTheme.bodyText1,
            ),
          ),
        ],
      ),*/
    );
  }

  double get topMargin {
    if ((isFirst)) {
      return 20;
    } else {
      return 0;
    }
  }

  double get bottomMargin {
    if ((isLast)) {
      return 10;
    } else {
      return 0;
    }
  }

  BorderRadius get buildBorderRadius {
    if (isFirst) {
      return BorderRadius.vertical(top: Radius.circular(10));
    }
    if (isLast) {
      return BorderRadius.vertical(bottom: Radius.circular(10));
    }
    if (!isFirst && !isLast) {
      return BorderRadius.all(Radius.circular(0));
    }
    return BorderRadius.all(Radius.circular(10));
  }
}
