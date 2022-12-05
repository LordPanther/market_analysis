// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
//
// Future main() async {
//
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp(
//     options: const FirebaseOptions(
//         apiKey: "AIzaSyC9Mcv4d3K-3yCT1buZCBEOFIWXhqr1C1M",
//         authDomain: "spartan-vine-242218.firebaseapp.com",
//         projectId: "spartan-vine-242218",
//         storageBucket: "spartan-vine-242218.appspot.com",
//         messagingSenderId: "68850936821",
//         appId: "1:68850936821:web:cfac2054d4f7ec61ac0ebc",
//         measurementId: "G-PZNP9NWT6R"
//     )
//   );
// }
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:market_app/utils/authentication.dart';
import 'package:market_app/utils/theme_data.dart';

import 'screens/home_page.dart';

void main() {
  runApp(
    EasyDynamicThemeWidget(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  Future getUserInfo() async {
    await getUser();
    setState(() {});
    print(uid);
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
      home: HomePage(),
    );
  }
}