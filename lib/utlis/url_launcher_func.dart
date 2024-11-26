import 'package:flutter/services.dart';
import 'package:offerzhub/utlis/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

Future launchUrlFunc(String? url) async {
  if (url == null || url.isEmpty) {
    AppSnackBar.showSnackBar("Offer unreachable😕", colorGreen: false);
  } else {
    try {
      await launchUrl(Uri.parse(url));
    } on PlatformException catch (e) {
      AppSnackBar.showSnackBar(e.message.toString(), colorGreen: false);
    }
  }
}
