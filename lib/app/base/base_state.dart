import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app/widget/text_widget.dart';
import '../../app/exports/app_values_export.dart';
import '../../app/exports/generated_values_export.dart';

abstract class BaseConsumerState<T extends ConsumerStatefulWidget> extends ConsumerState<T> {
  AppBar navigationAppBar({
    String? title,
    bool isCenterTitle = true,
    bool isTranslatable = true,
    List<Widget>? actionWidgets,
    required Function() clickIcon,
  }) {
    return AppBar(
      centerTitle: isCenterTitle,
      title: _getTitle(
        title,
        isTranslatable,
      ),
      backgroundColor: colorWhite,
      iconTheme: const IconThemeData(
        color: colorPrimary,
      ),
      actions: [
        if (actionWidgets != null && actionWidgets.isNotEmpty) ...[
          ...actionWidgets,
        ],
        // GetX<NotificationController>(
        //   init: NotificationController(),
        //   builder: (controller) {
        //     return Container(
        //       margin: const EdgeInsets.only(top: 14, right: 8),
        //       width: 30,
        //       height: 30,
        //       child: GestureDetector(
        //         onTap: () {
        //           if (controller.unreadCounter.value > 0) {
        //             controller.markAsRead();
        //           }

        //           clickIcon();
        //         },
        //         child: Stack(
        //           children: [
        //             const Icon(
        //               Icons.notifications,
        //               color: colorPrimary,
        //               size: 27,
        //             ),
        //             Visibility(
        //               visible: controller.unreadCounter.value > 0,
        //               child: Container(
        //                 width: 28,
        //                 height: 28,
        //                 alignment: Alignment.topRight,
        //                 margin: const EdgeInsets.only(top: 3.5, right: 2),
        //                 child: Container(
        //                   width: 14,
        //                   height: 14,
        //                   decoration: BoxDecoration(
        //                     shape: BoxShape.circle,
        //                     color: const Color(0xffc32c37),
        //                     border: Border.all(color: Colors.white, width: 0.3),
        //                   ),
        //                   child: Padding(
        //                     padding: const EdgeInsets.only(top: 1.5),
        //                     child: Center(
        //                       child: Text(
        //                         controller.unreadCounter.value > 99
        //                             ? "99+"
        //                             : "${controller.unreadCounter.value}",
        //                         style: const TextStyle(fontSize: 7),
        //                       ),
        //                     ),
        //                   ),
        //                 ),
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     );
        //   },
        // ),
      ],
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

  AppBar myAppBar({
    String? title,
    bool isNavigate = true,
    bool isCenterTitle = true,
    bool isTranslatable = true,
    bool backToProviderHome = false,
    bool backToCustomerHome = false,
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

  Widget noDataFoundWidget({
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
