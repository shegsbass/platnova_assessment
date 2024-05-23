import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart' hide ChangeNotifierProvider;

import '../../di/injection_container.dart';
import '../../di/providers/user_provider.dart';
import '../components/common/colors.dart';
import '../components/common/theme.dart';
import '../screens/user/user_screen.dart';
import 'data_utils/storage/shared_preference.dart';

class PlatnovaApp extends ConsumerStatefulWidget {
  const PlatnovaApp({super.key});

  @override
  ConsumerState<PlatnovaApp> createState() => _PlatnovaAppState();
}

ThemeController themeChangeProvider = ThemeController(ThemeNotifier());

class _PlatnovaAppState extends ConsumerState<PlatnovaApp> {
  LocalDataSource localDataSource = sl();
  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async {
    themeChangeProvider.darkTheme = localDataSource.getTheme() ?? false;
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: PlatnovaColors.primary,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
    print(themeChangeProvider.darkTheme);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Platnova',
       navigatorKey: ref.read(mainKeyProvider),
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(context, themeChangeProvider.darkTheme),
      home: const UserScreen(),
      //builder: EasyLoading.init(),
    );
  }
}
