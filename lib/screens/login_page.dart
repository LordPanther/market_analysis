import 'package:flutter/material.dart';
import 'package:market_app/screens/home_page.dart';
import 'package:market_app/utils/authentication.dart';
import 'package:market_app/widgets/auth_dialog.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: Consumer<Authentication>(
        builder: (context, auth, child) {
          return auth.userEmail != null ? const HomePage() : AuthDialog();
        },
      ),
    );
  }
}
