import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:lab_app/data/models/intermediate_place_pick_result.dart';
import 'package:lab_app/utils/constant/google_map_keys.dart';

class LocationPickerWidget extends StatelessWidget {
  final bool isRequired;
  final String keyName;

  // final String value;
  final ValueChanged<AddressLocation?>? onChange;
  final Color? fillColor;

  // final Color labelTextColor;
  final AddressLocation? initialValue;

  // final String labelText;

  LocationPickerWidget({
    Key? key,
    // this.onTap,
    this.isRequired = true,
    required this.keyName,
    // this.value,
    this.onChange,
    this.fillColor,
    this.initialValue,
    // this.labelTextColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AutoSizeText(
          keyName.tr,
          style: Get.textTheme.subtitle2,
        ),
        FormBuilderField<AddressLocation>(
            name: keyName,
            onChanged: onChange,
            initialValue: initialValue,
            validator: FormBuilderValidators.compose([
              if (isRequired) FormBuilderValidators.required(context),
            ]),
            builder: (FormFieldState<AddressLocation> field) {
              return InputDecorator(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.only(top: 10.0, bottom: 0.0),
                  border: InputBorder.none,
                  errorText: field.errorText,
                ),
                child: Theme(
                  data: ThemeData(
                      textTheme: TextTheme(
                    subtitle1: TextStyle(color: Colors.black),
                    subtitle2: TextStyle(color: Colors.black),
                    bodyText1: TextStyle(color: Colors.black),
                    bodyText2: TextStyle(color: Colors.black),
                  )),
                  child: PlacePicker(
                    apiKey: GoogleMapApiKeys.getGetKey(),

                    onPlacePicked: (PickResult pickedResult) {
                      AddressLocation intermediateResult =
                          AddressLocation.fromPickResult(pickedResult);

                      field.didChange(intermediateResult);
                      Get.back();
                    },
                    // autocompleteComponents: [
                    //   Component(Component.country, 'AE')
                    // ],
                    initialPosition:
                        initialValue?.latLng ?? LatLng(24.466667, 54.366669),
                    useCurrentLocation: initialValue == null ? true : false,
                    selectInitialPosition: true,
                    enableMapTypeButton: true,
                    enableMyLocationButton: true,
                  ),
                ),
                // child: GestureDetector(
                //   onTap: () {
                //     Get.to(()=>Theme(
                //       data: ThemeData(
                //           textTheme: TextTheme(
                //         subtitle1: TextStyle(color: Colors.black),
                //         subtitle2: TextStyle(color: Colors.black),
                //         bodyText1: TextStyle(color: Colors.black),
                //         bodyText2: TextStyle(color: Colors.black),
                //       )),
                //       child: PlacePicker(
                //         apiKey: GoogleMapApiKeys.getGetKey(),
                //         onPlacePicked: (PickResult pickedResult) {
                //           // controller.selectedPlace = result;
                //           AddressLocation intermediateResult =
                //           AddressLocation(
                //             placeId: pickedResult.placeId,
                //             placeName: pickedResult.formattedAddress,
                //             latLng: LatLng(
                //               pickedResult.geometry!.location.lat,
                //               pickedResult.geometry!.location.lng,
                //             ),
                //           );
                //           field.didChange(intermediateResult);
                //           print(intermediateResult);
                //           Get.back();
                //         },
                //         // autocompleteComponents: [
                //         //   Component(Component.country, 'AE')
                //         // ],
                //         initialPosition: initialValue?.latLng ??
                //             LatLng(24.466667, 54.366669),
                //         useCurrentLocation: initialValue == null ? true : false,
                //         selectInitialPosition: true,
                //         enableMapTypeButton: true,
                //         enableMyLocationButton: true,
                //       ),
                //     ));
                //   },
                //   child: Container(
                //     padding: EdgeInsets.all(12.0),
                //     decoration: BoxDecoration(
                //       color:  fillColor ?? Get.theme.inputDecorationTheme.fillColor,
                //       borderRadius:  BorderRadius.all(Radius.circular(8)),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //       children: [
                //         Icon(
                //           Icons.location_on_outlined,
                //           color: Colors.grey,
                //         ),
                //         UiHelper.horizontalSpaceTiny,
                //         Expanded(
                //           child: AutoSizeText(
                //             field.value?.placeName ?? value ?? 'none',
                //             style: Get.textTheme.subtitle2.copyWith(
                //                 // color: labelTextColor ?? Get.theme.primaryColor,
                //                 ),
                //             // overflow: ,
                //           ),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
              );
            }),
      ],
    );
  }
}
