import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:getx_tutorial/common/dismiss_keyboard.dart';
import 'package:getx_tutorial/common/theme.dart';
import 'package:getx_tutorial/views/home_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  await GetStorage.init();
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.transparent, // transparent status bar
  ));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Themes.lightTheme,
        darkTheme: Themes.darkTheme,
        //themeMode: ThemeMode.system,
        home: HomePage(),
      ),
    );
  }
}


/// Todo; Add Dark Theme
/// Todo; Find & Add A Cool Graph package
/// Todo; toast to undo feature
/// Todo; Local Notification if no record added for a week!
