import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';
import '../../app/values/app_fonts.dart';
import '../../app/values/app_colors.dart';
import '../../app/widget/text_widget.dart';
import '../../app/widget/image_view_widget.dart';

class CustomNavigationDrawerWidget extends StatefulWidget {
  const CustomNavigationDrawerWidget({
    Key? key,
  }) : super(key: key);

  @override
  _UserCustomNavigationDrawerComponentState createState() =>
      _UserCustomNavigationDrawerComponentState();
}

class _UserCustomNavigationDrawerComponentState
    extends State<CustomNavigationDrawerWidget> {
  String? name;
  String? userType;

  @override
  void initState() {
    // _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(top: 42),
        decoration: BoxDecoration(
            shape: BoxShape.rectangle, color: colorWhite.withOpacity(0.8)),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _accountHeader(context),
            const SizedBox(
              height: 16,
            ),
            _createDrawerItem(
              Icons.home,
              text: "breaker",
              onTap: () {
                // Get.back();
              },
            ),
            _createDrawerItem(
              Icons.remove_red_eye_rounded,
              text: "watch_list",
              onTap: () {
                // Navigator.of(context).pop();
                // Get.to(() => const WatchListScreen(), transition: sendTransition);
              },
            ),
            _createDrawerItem(
              Icons.notifications,
              text: "notifications",
              onTap: () {
                // Navigator.of(context).pop();
                // Get.to(() => const NotificationScreen(), transition: sendTransition);
              },
            ),
            _createDrawerItem(
              Icons.logout,
              text: "logout",
              // onTap: () => _logoutAlertDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountHeader(context) {
    return Container(
      margin: const EdgeInsets.only(top: 32.0),
      color: Colors.white,
      child: Column(
        children: [
          ImageViewWidget(
            imageUrl: Assets.icons.userPlaceholder.path,
            placeHolderIcon: Assets.icons.userPlaceholder.path,
            borderWidth: 0.2,
            borderColor: colorPrimary,
            height: 95,
            width: 95,
          ),
          TextWidget(
            name ?? "Guest User",
            fontSize: textFontSize,
            maxLines: 3,
            textOverflow: TextOverflow.ellipsis,
            fontWeight: mediumFontWeight,
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
          ),
          TextWidget(
            userType?.replaceAll("_", " ") ?? "",
            fontSize: smallFontSize,
            textOverflow: TextOverflow.ellipsis,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          ),
          const Divider(),
        ],
      ),
    );
  }

  // void _logoutAlertDialog() {
  //   Get.defaultDialog(
  //     title: "Logout",
  //     textConfirm: "Logout",
  //     textCancel: "Cancel",
  //     radius: 14,
  //     content: const Text(
  //       "want_to_logout",
  //       textAlign: TextAlign.center,
  //     ).tr(),
  //     confirmTextColor: Colors.white,
  //     titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
  //     contentPadding: const EdgeInsets.all(16),
  //     onConfirm: () async {
  //       loading(value: "Please wait...");
  //       await logout();
  //     },
  //   );
  // }

  Widget _createDrawerItem(IconData icon,
      {String? text, GestureTapCallback? onTap, double size = 24}) {
    return ListTile(
      dense: true,
      title: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 12.0),
            child: Icon(
              icon,
              color: colorPrimary,
              size: size,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextWidget(
              text,
              fontSize: textSmallFontSize,
              fontWeight: mediumFontWeight,
              textAlign: TextAlign.start,
              padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  // Future<void> _loadUserInfo() async {
  //   SharedPref.read(keyUserName).then((userName) {
  //     if(userName != null) {
  //       setState(() {
  //         name = userName;
  //       });
  //     }
  //   });

  //   SharedPref.read(keyUserType).then((type) {
  //     if(type != null) {
  //       setState(() {
  //         userType = type;
  //       });
  //     }
  //   });
  // }
}
