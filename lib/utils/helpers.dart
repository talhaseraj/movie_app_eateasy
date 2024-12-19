import 'package:flutter/foundation.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:movie_app_eateasy/movieapp_theme.dart';

OverlayEntry overlayEntry = OverlayEntry(builder: (context) {
  return SafeArea(
    child: Material(
      color: Colors.transparent,
      child: Container(
        height: double.infinity,
        color: Colors.black.withOpacity(.6),
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWave(
              color: MovieappTheme.c_02B4E4,
            )
          ],
        ),
      ),
    ),
  );
});

class Helpers {
  static void removeLoadingOverLay() {
    overlayEntry.remove();
  }

  static void addLoadingOverlay(
    BuildContext context,
  ) async {
    OverlayState overlayState = Overlay.of(context);
    // inserting overlay entry
    overlayState.insert(overlayEntry);
  }

  //return true if connected
  static Future<bool> checkInternetConnectionStatus() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (kDebugMode) {
      print(connectivityResult);
    }

    if (!(connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi)) {
      return false;
    } else {
      return true;
    }
  }
}
