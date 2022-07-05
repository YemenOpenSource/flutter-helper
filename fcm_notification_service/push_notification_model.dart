
import 'package:flutter/material.dart';

import '../../helper/navigator_key.dart';
import '../../helper/type_convert.dart';

class PushNotification {
  String? titleEn;
  String? titleAr;
  String? bodyEn;
  String? bodyAr;
  String? icon;

  PushNotification({
    this.titleEn,
    this.titleAr,
    this.bodyEn,
    this.bodyAr,
    this.icon,
  });

  factory PushNotification.fromMap(Map<String, dynamic> map) {
    return PushNotification(
      titleEn: TypeConvert.convertToString(map['titleEn']),
      titleAr: TypeConvert.convertToString(map['titleAr']),
      bodyEn: TypeConvert.convertToString(map['bodyEn']),
      bodyAr: TypeConvert.convertToString(map['bodyAr']),
      icon: TypeConvert.convertToString(map['icon']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'titleEn': titleEn,
      'titleAr': titleAr,
      'bodyEn': bodyEn,
      'bodyAr': bodyAr,
      'icon': icon,
    };
  }

  String? get title {
    if (Localizations.localeOf( NavigatorKey.navigatorKey.currentContext!).languageCode !=
        const Locale("ar").languageCode) {
      return titleAr ?? titleEn;
    }
    return titleEn ?? titleAr;
  }

  String? get body {
    if (Localizations.localeOf( NavigatorKey.navigatorKey.currentContext!).languageCode !=
        const Locale("ar").languageCode) {
      return bodyAr ?? bodyEn;
    }
    return bodyEn ?? bodyAr;
  }
}
