// import 'dart:io';
// import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get/get.dart';
// import 'package:image_picker_widget/image_picker_widget.dart';
// import 'package:form_builder_validators/form_builder_validators.dart';
// import 'package:lab_app/language_and_localization/app_strings.dart';
// import 'package:lab_app/utils/app_ui_helper/ui_helpers.dart';
// import 'package:lab_app/utils/constant/app_images.dart';
//
// class ImagePickerFormBuilderField extends StatelessWidget {
//   final dynamic initialImage;
//   final String? title;
//   final String keyName;
//   final bool? isRequired;
//   final double? diameter;
//
//   // final double height;
//   // final double width;
//   // final double squareBorderRadius;
//   final ImagePickerWidgetShape? shape;
//   final EdgeInsetsGeometry? paddingIcon;
//   final Color? backgroundColor;
//   final Function(dynamic)? onChange;
//   final bool isMemberPlaceHolder;
//
//   // final Function onChange;
//
//   const ImagePickerFormBuilderField({
//     Key? key,
//     this.initialImage,
//     required this.keyName,
//     this.isRequired = false,
//     this.diameter,
//     this.title,
//     this.shape,
//     // this.height,
//     // this.width,
//     this.paddingIcon,
//     this.backgroundColor,
//     // this.squareBorderRadius,
//     this.onChange,
//     this.isMemberPlaceHolder = true,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisSize: MainAxisSize.min,
//       mainAxisAlignment: MainAxisAlignment.start,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Visibility(
//           visible: title != null,
//           child: AutoSizeText(
//             title ?? '',
//             style: Get.textTheme.subtitle2,
//           ),
//         ),
//         FormBuilderField(
//           name: keyName,
//           onChanged: onChange,
//           validator: FormBuilderValidators.compose([
//             if (isRequired!) FormBuilderValidators.required(context),
//           ]),
//           initialValue: initialImage,
//           builder: (FormFieldState field) {
//             return InputDecorator(
//               decoration: InputDecoration(
//                 contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
//                 border: InputBorder.none,
//                 errorText: field.errorText,
//                 filled: false,
//               ),
//               child: Center(
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//                     ImagePickerWidget(
//                       diameter: diameter ?? 90.r,
//                       modalTitle: Text(
//                         LabAppStrings.clickToSelectAnImage.tr.capitalizeFirst!,
//                       ),
//                       backgroundColor: backgroundColor,
//                       initialImage: initialImage ??
//                           AssetImage(
//                             isMemberPlaceHolder
//                                 ? AppImages.userProfilePlaceHolderPng
//                                 : AppImages.logo,
//                           ),
//                       shape: shape ?? ImagePickerWidgetShape.circle,
//                       isEditable: true,
//                       onChange: (File val) {
//                         field.didChange(val);
//                       },
//                       editIcon: Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(4.0),
//                           child: Icon(
//                             Icons.edit,
//                             size: 16.sp,
//                           ),
//                         ),
//                       ),
//                     ),
//                     UiHelper.verticalSpaceMedium,
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
