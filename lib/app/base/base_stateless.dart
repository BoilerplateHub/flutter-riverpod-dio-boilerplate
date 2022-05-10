import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../app/values/app_colors.dart';
import '../../app/values/app_fonts.dart';
import '../../app/values/size_config.dart';
import '../../app/widget/text_widget.dart';
import '../../translations/locale_keys.g.dart';

abstract class BaseStateless {
  AppBar myAppBar({
    String? title,
    bool isNavigate = true,
    bool isCenterTitle = true,
    bool isTranslatable = true,
    bool backToProviderHome = false,
    bool backToCustomerHome = false,
    bool backToOrderDetails = false,
    List<Widget>? actions,
  }) {
    return AppBar(
      elevation: isNavigate ? 1.4 : 0,
      iconTheme: const IconThemeData(
        color: colorPrimary,
      ),
      centerTitle: isCenterTitle,
      title: _getTitle(
        title,
        isTranslatable,
      ),
      backgroundColor: Colors.white,
      leading: isNavigate
          ? GestureDetector(
              onTap: () {
                // Get.back();
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.arrow_back_outlined,
                  color: colorPrimary,
                ),
              ),
            )
          : null,
      actions: actions,
    );
  }

  Text? _getTitle(String? title, bool isTranslatable) {
    if (title != null && title != "") {
      var textStyle = GoogleFonts.getFont(
        defaultFont,
        fontWeight: mediumFontWeight,
        color: colorPrimary,
        fontSize: appBarFontSize,
      );

      if (isTranslatable) {
        return Text(
          title,
          style: textStyle,
        );
      } else {
        return Text(
          title,
          style: textStyle,
        );
      }
    }

    return null;
  }

  // void resetGetXValues(List<Rxn<dynamic>?>? args) {
  //   if (args != null) {
  //     for (var arg in args) {
  //       arg?.value = null;
  //     }
  //   }
  // }

  // bool isBlank(List<dynamic>? args) {
  //   if (args != null) {
  //     for (var arg in args) {
  //       if (arg == null) {
  //         return true;
  //       } else if (arg is String && arg.trim().isEmpty) {
  //         return true;
  //       }
  //     }
  //   }

  //   return false;
  // }

  Widget noDataFoundWidget(
    BuildContext context, {
    String? message,
    double divider = 1,
  }) {
    return SizedBox(
      height: SizeConfig.getScreenHeight(context) / divider,
      width: SizeConfig.getScreenWidth(context),
      child: Center(
        child: TextWidget(
          message ?? LocaleKeys.no_data_found.tr(),
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
