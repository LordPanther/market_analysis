import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_app/routes/route.dart';
import 'package:market_app/screens/login_page.dart';
import 'package:market_app/utils/authentication.dart';
import 'package:market_app/utils/constants.dart';
import 'package:market_app/utils/theme_data.dart';
import 'package:market_app/widgets/auth_dialog.dart';
import 'package:provider/provider.dart';

import 'models/app_auth.dart';
import 'screens/home_page.dart';

Future main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: authData
  );

  runApp(
    EasyDynamicThemeWidget(
      child: MultiProvider(providers: [
        ChangeNotifierProvider(create: (_) => Authentication())
      ],
      child: MyApp()),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future getUserInfo() async {
    await Authentication().getUser();
    setState(() {});
  }

  @override
  void initState() {
    getUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Explore',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      debugShowCheckedModeBanner: false,
      themeMode: EasyDynamicTheme.of(context).themeMode,
      initialRoute: RouteManager.loginPage,
      onGenerateRoute: RouteManager.generateRoute,
    );
  }
}

//userEmail == null ? AuthDialog() : const HomePage()