import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../di/injection_container.dart';
import '../../util/data_utils/storage/shared_preference.dart';
import 'colors.dart';

class PlatnovaTheme {
  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      textSelectionTheme: const TextSelectionThemeData(cursorColor: Color(0xFF777E90)),
      primaryColor: isDarkTheme ? Colors.black : Colors.white,

      indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
      // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),

      hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),

      highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
      hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),

      focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      //textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
      cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
      canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
      brightness: isDarkTheme ? Brightness.dark : Brightness.light,
      buttonTheme: Theme.of(context).buttonTheme.copyWith(
          colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
      iconTheme: IconThemeData(
          color:
              isDarkTheme ? PlatnovaColors.primary : PlatnovaColors.primary),
      appBarTheme: const AppBarTheme(
        elevation: 0.0,
      ),
      colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red)
          .copyWith(background: isDarkTheme ? Colors.black : const Color(0xffF1F5FB)),
    );
  }
}

ThemeData getAppTheme(BuildContext context, bool isDarkTheme) {
  return ThemeData(
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Color(0xFF777E90)),
    primaryColor: isDarkTheme ? Colors.black : Colors.white,

    indicatorColor: isDarkTheme ? const Color(0xff0E1D36) : const Color(0xffCBDCF8),
    // buttonColor: isDarkTheme ? Color(0xff3B3B3B) : Color(0xffF1F5FB),

    hintColor: isDarkTheme ? const Color(0xff280C0B) : const Color(0xffEECED3),

    highlightColor: isDarkTheme ? const Color(0xff372901) : const Color(0xffFCE192),
    hoverColor: isDarkTheme ? const Color(0xff3A3A3B) : const Color(0xff4285F4),

    focusColor: isDarkTheme ? const Color(0xff0B2512) : const Color(0xffA8DAB5),
    disabledColor: Colors.grey,
    //textSelectionColor: isDarkTheme ? Colors.white : Colors.black,
    cardColor: isDarkTheme ? const Color(0xFF151515) : Colors.white,
    canvasColor: isDarkTheme ? Colors.black : Colors.grey[50],
    // brightness: isDarkTheme ? Brightness.dark : Brightness.light,

    buttonTheme: Theme.of(context)
        .buttonTheme
        .copyWith(colorScheme: isDarkTheme ? const ColorScheme.dark() : const ColorScheme.light()),
    iconTheme: IconThemeData(
        color: isDarkTheme ? PlatnovaColors.primary : PlatnovaColors.primary),
    appBarTheme: const AppBarTheme(
      elevation: 0.0,
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.red).copyWith(
        //   brightness: isDarkTheme ? Brightness.dark : Brightness.light,
        background: isDarkTheme ? Colors.black : const Color(0xffF1F5FB)),
  );
}

// final themeProvider =
// // StateNotifierProvider takes the controller class and state class as type arguments
//     StateNotifierProvider<ThemeController, AsyncValue<void>>((ref) {
//   return ThemeController();
// });

class ThemeNotifier extends ChangeNotifier {
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    // Notify listeners of the theme change.
    notifyListeners();
  }
}

class ThemeController extends StateNotifier<AsyncValue<bool>> {
  //ThemeController() : super(const AsyncData<bool>(false));
  LocalDataSource localDataSource = sl();
  bool _darkTheme = false;
  final ThemeNotifier themeNotifier;

  ThemeController(this.themeNotifier) : super(const AsyncData<bool>(false));

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    localDataSource.setDarkTheme(value: value);
    state = AsyncData(value);
    // Update the theme using the notifier.
    themeNotifier.darkTheme = value;
  }
}
