import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app/base/base_state.dart';

class WebViewComponent extends ConsumerStatefulWidget {
  final String? title;

  const WebViewComponent({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  WebViewComponentState createState() => WebViewComponentState();
}

class WebViewComponentState extends BaseConsumerState<WebViewComponent> {
  // final _authController = Get.put(AuthController());

  @override
  void initState() {
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
    String? title = widget.title;

    // if(title == "terms_of_service") {
    //   _authController.getLegalDocs(termsConditionsEndpoint);
    // } else if(title == "privacy_policy") {
    //   _authController.getLegalDocs(privacyPolicyEndpoint);
    // }

    super.initState();
  }

  void _onNavigationDelegateHtml(
      WebViewController controller, /*CommonResponse?*/ dynamic legalDocsPayload) async {
    var content = """
    <!DOCTYPE html>
      <html>
      <head><meta name="viewport" content="width=device-width, initial-scale=1.0"></head>
      <body style='"margin: 0; padding: 0;'>
        <div>
          ${legalDocsPayload?.payload}
        </div>
      </body>
    </html>
    """;

    final String contentBase64 =
        base64Encode(const Utf8Encoder().convert(content));
    await controller.loadUrl('data:text/html;base64,$contentBase64');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(title: widget.title),
      body: noDataFoundWidget(),
      // body: GetBuilder<AuthController> (
      //   builder: (authController) {
      //     var payload = authController.legalDoc;

      //     if(payload != null) {
      //       return WebView(
      //         initialUrl: '',
      //         onWebViewCreated: (controller) {
      //           _onNavigationDelegateHtml(controller, payload);
      //         },
      //         onPageStarted: (progress) {
      //           EasyLoading.dismiss();
      //         },
      //       );
      //     } else {
      //       return noDataFoundWidget();
      //     }
      //   },
      // ),
    );
  }
}
