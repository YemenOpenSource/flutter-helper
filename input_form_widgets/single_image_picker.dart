import 'dart:io';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get.dart';
import 'package:lab_app/language_and_localization/app_strings.dart';

class ImagePickerWidgetForm extends StatefulWidget {
  final BoxDecoration doxDecoration;
  final double height;
  final double width;
  final double radiusCircular;
  final AlignmentGeometry alignmentGeometry;
  final Widget image;
  final Widget iconClick;
  final String keyName;
  final bool isRequired;
  final Function upLoudImage;

  ImagePickerWidgetForm({
    Key? key,
    required this.doxDecoration,
    required this.height,
    required this.width,
    required this.radiusCircular,
    required this.alignmentGeometry,
    required this.image,
    required this.keyName,
    required this.isRequired,
    required this.upLoudImage,
    required this.iconClick,
  }) : super(key: key);

  @override
  _ImagePickerWidgetState createState() => _ImagePickerWidgetState();
}

class _ImagePickerWidgetState extends State<ImagePickerWidgetForm> {
  File? storedIma;
  File? savedIma;

  Future<void> _takePicture(ImageSource source, dynamic field) async {
    final picker = ImagePicker();

    final imageFile = await picker.pickImage(
      source: source,
      maxWidth: 600,
    );
    if (imageFile == null) return;

    storedIma = File(imageFile.path);

    field.didChange(storedIma);

    setState(() {});
    savedIma = File(imageFile.path);
    widget.upLoudImage(storedIma);
    Get.back();
  }

  void _startAddNewTransaction(BuildContext ctx, dynamic field) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return Container(
            padding: const EdgeInsets.all(0),
            color: Get.theme.scaffoldBackgroundColor,
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading:
                      Icon(Icons.camera_enhance, color: Get.theme.primaryColor),
                  title: Text(
                    LabAppStrings.camera.tr,
                    style: Get.textTheme.bodyText2,
                  ),
                  onTap: () => _takePicture(ImageSource.camera, field),
                ),
                ListTile(
                  leading: Icon(
                    Icons.image,
                    color: Get.theme.primaryColor,
                  ),
                  title: Text(
                    AppStrings.gallery.tr,
                    style: Get.textTheme.bodyText2,
                  ),
                  onTap: () => _takePicture(ImageSource.gallery, field),
                )
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return FormBuilderField(
      name: widget.keyName,
      validator: FormBuilderValidators.compose([
        if (widget.isRequired) FormBuilderValidators.required(context),
      ]),
      builder: (FormFieldState<dynamic> field) {
        return Stack(alignment: Alignment.bottomCenter, children: <Widget>[
          Container(
            decoration: widget.doxDecoration,
            height: widget.height,
            width: widget.width,
            clipBehavior: Clip.antiAlias,
            child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(widget.radiusCircular)),
                child: storedIma == null
                    ? widget.image
                    : Image.file(
                        storedIma!,
                        fit: BoxFit.fill,
                        height: widget.height,
                        width: widget.width,
                      )),
          ).paddingOnly(bottom: 15),
          Align(
              alignment: widget.alignmentGeometry,
              //Alignment.bottomLeft,
              child: InkWell(
                  onTap: () => _startAddNewTransaction(context, field),
                  child: widget.iconClick)
              // new IconButton(
              //     onPressed: ()=>
              //         Get.find<AuthService>().isAuth?
              //       _startAddNewTransaction(context,field) :
              //       Get.toNamed(LoginScreen.id),
              //       icon: Icon( Icons.add_a_photo,
              //       color:AppColors.grey.withOpacity(0.5),
              //       size: 35,
              //     )
              // )
              ),
        ]);
      },
    );
  }
}
