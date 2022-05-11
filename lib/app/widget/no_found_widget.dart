import 'package:flutter/material.dart';
import '../../app/exports/generated_values_export.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({
    Key? key,
    this.exception,
  }) : super(key: key);

  final Exception? exception;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LocaleKeys.pageNotFound.tr()),
      ),
      body: Center(
        child: Text(
          exception != null
              ? exception.toString()
              : LocaleKeys.pageNotFound.tr(),
        ),
      ),
    );
  }
}
