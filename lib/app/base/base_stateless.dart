import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:thrive_mobile_app/app/provider/core_providers.dart';

import '../../app/widget/text_widget.dart';
import '../../shared/utils/extensions.dart';

import '../../app/exports/app_values_export.dart';
import '../../app/exports/generated_values_export.dart';

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

  // Future<bool?> showToast(
  //   String message, {
  //   int timeInSec = 1,
  //   ToastGravity toastGravity = ToastGravity.CENTER,
  //   Toast toastLength = Toast.LENGTH_SHORT,
  // }) {
  //   return Fluttertoast.showToast(
  //       msg: message,
  //       gravity: toastGravity,
  //       toastLength: toastLength,
  //       timeInSecForIosWeb: timeInSec,
  //       backgroundColor: Colors.red,
  //       textColor: Colors.white,
  //       fontSize: 16.0);
  // }

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

  Future<bool> isInternetConnected(
    Reader reader,
    BuildContext context, {
    bool isShowAlert = false,
  }) async {
    bool isConnected = false;

    try {
      var connectivityResult = await reader(connectivityProvider).checkConnectivity();

      if (connectivityResult == ConnectivityResult.mobile ||
          connectivityResult == ConnectivityResult.wifi) {
        isConnected = true;
      }
    } catch (_) {}

    if (isShowAlert && !isConnected) {
      LocaleKeys.internetConnectivityProblem.tr().errorToast();
      // showMessage("Internet Connectivity Problem");
    }

    return isConnected;
  }

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
