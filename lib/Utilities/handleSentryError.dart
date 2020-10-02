import 'package:flutter/material.dart';
import '../main.dart';

void handleSentryError({String errorMessage, @required String auditor}) async {
  await sentry.captureException(
    exception: errorMessage + ":::" + auditor,
    stackTrace: "",
  );
}
