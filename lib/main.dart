
import 'package:baby_diary/common/firebase/firebase_option.dart';
import 'package:baby_diary/common/firebase/firebase_user.dart';
import 'package:baby_diary/routes/route_name.dart';
import 'package:baby_diary/routes/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(name: 'BabyDiary',options: DefaultFirebaseOptions.currentPlatform);
  runApp(const BabyDiary());
}

class BabyDiary extends StatelessWidget {
  const BabyDiary({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
  FirebaseAnalyticsObserver(analytics: analytics);

  void saveUserLog() async {
    await FirebaseUser.instance.addUser();
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Routes.instance.navigatorKey,
      themeMode: ThemeMode.light,
      onGenerateRoute: Routes.generateRoute,
      builder: (context, child) => MediaQuery(
          data:
          MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!),
      initialRoute: RoutesName.tabBarRoute,
    );
  }
}
