import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:medcare/pages/OnBoardingScreen.dart';
import 'package:medcare/pages/bottom_bar.dart';
import 'package:medcare/pages/homepage/index.dart';
import 'package:medcare/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'config/themes/theme.dart';
import 'package:provider/provider.dart';

main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final showHome = prefs.getBool('showHome')?? false;
  runApp(MyApp(showHome: showHome));
  AwesomeNotifications().initialize(null, [
    NotificationChannel(
      locked: true,
      channelKey: 'pill_channel',
      channelName: 'Pill Reminder',
      defaultColor: const Color(0xff020202),
      importance: NotificationImportance.High,
      channelShowBadge: true,
      channelDescription: 'Description',
    ),
  ]);
  await AwesomeNotifications().requestPermissionToSendNotifications();
}

class MyApp extends StatefulWidget {
  final bool showHome;
  const MyApp({Key? key, required this.showHome}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (context) => ThemeProvider())
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'MedCare',
            themeMode: themeProvider.themeMode,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            initialRoute: RouteManager.homePage,
            onGenerateRoute: RouteManager.generateRoute,
            home: widget.showHome ? const BottomBar() : const OnBoardingScreen(),);
        })
    ;
  }
}
