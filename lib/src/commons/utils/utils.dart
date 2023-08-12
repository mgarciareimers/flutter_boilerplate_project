import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;

// Constants.
import 'package:flutter_boilerplate_project/src/commons/constants/custom_colors.dart';
import 'package:flutter_boilerplate_project/src/commons/constants/sizes.dart';
import 'package:flutter_boilerplate_project/src/commons/constants/strings.dart';

// Widgets.
import 'package:flutter_boilerplate_project/src/widgets/generic/progress_bar.dart';

class Utils {
  // Method that shows an alert dialog.
  static void showAlertDialog(BuildContext context, String? title, String? content, String? positiveName, String? negativeName, dynamic positiveAction, dynamic negativeAction) {
    if (Platform.isIOS) {
      showCupertinoAlertDialog(context, title, content, positiveName, negativeName, positiveAction, negativeAction);
    } else {
      showMaterialAlertDialog(context, title, content, positiveName, negativeName, positiveAction, negativeAction);
    }
  }

  // Method that shows the material alert dialog.
  static void showMaterialAlertDialog(BuildContext context, String? title, String? content, String? positiveName, String? negativeName, dynamic positiveAction, dynamic negativeAction) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: AlertDialog(
            title: Text(title!),
            content: Text(content!, style: const TextStyle(fontSize: Sizes.font14)),
            actions: <Widget>[
              negativeAction == null ? Container() : TextButton(
                child: Text(negativeName!, style: const TextStyle(color: CustomColors.red, fontSize: Sizes.font16)),
                onPressed: () => negativeAction(context),
              ),
              TextButton(
                child: Text(positiveName!, style: const TextStyle(color: CustomColors.green, fontSize: Sizes.font16)),
                onPressed: () => positiveAction(context),
              ),
            ]
          ),
        );
      }
    );
  }

  // Method that shows the cupertino alert dialog.
  static void showCupertinoAlertDialog(BuildContext context, String? title, String? content, String? positiveName, String? negativeName, dynamic positiveAction, dynamic negativeAction) {
    showCupertinoDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: CupertinoAlertDialog(
            title: Text(title!),
            content: Text(content!, style: const TextStyle(fontSize: Sizes.font14)),
            actions: <Widget>[
              negativeAction == null ? Container() : CupertinoDialogAction(
                isDefaultAction: false,
                child: Text(negativeName!, style: const TextStyle(color: CustomColors.red, fontSize: Sizes.font16)),
                onPressed: () => negativeAction(context),
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text(positiveName!, style: const TextStyle(color: CustomColors.green, fontSize: Sizes.font16)),
                onPressed: () => positiveAction(context),
              ),
            ],
          ),
        );
      },
    );
  }

  // Method that shows the progressbar alert dialog.
  static void showProgressBarAlertDialog(BuildContext context, Stream stream, Color color) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return WillPopScope(
          onWillPop: () async => false,
          child: ProgressBar(stream: stream, color: color)
        );
      },
    );
  }

  // Method that checks if the devices is connected to internet.
  static Future<bool> deviceIsConnected() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    return connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi;
  }

  // Method that loads an url.
  static void loadUrl(String url, { LaunchMode mode = LaunchMode.platformDefault }) async {
    await launchUrl(
      Uri.parse(url),
      mode: mode
    );
  }

  // Method that gets the bytes from an asset.
  static Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  // Method that gets a string from date.
  static String getStringFromDate(DateTime date) {
    return '${ date.year }-${ date.month.toString().padLeft(2, Strings.zero) }-${ date.day.toString().padLeft(2, Strings.zero) }T${ date.hour.toString().padLeft(2, Strings.zero) }:${ date.minute.toString().padLeft(2, Strings.zero) }:${ date.second.toString().padLeft(2, Strings.zero) }';
  }

}