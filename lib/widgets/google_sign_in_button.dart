import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/home_page.dart';
import '../utils/authentication.dart';

class GoogleButton extends StatefulWidget {
  const GoogleButton({super.key});

  @override
  _GoogleButtonState createState() => _GoogleButtonState();
}

class _GoogleButtonState extends State<GoogleButton> {

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: Consumer<Authentication>(
        builder: (context, auth, child) {
          return OutlinedButton(
            style: OutlinedButton.styleFrom(
              primary: Colors.blueGrey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: const BorderSide(color: Colors.blueGrey, width: 3),
              ),
              elevation: 0,
            ),
            onPressed: () async {
              setState(() {
                _isProcessing = true;
              });
              await auth.signInWithGoogle().then((result) {
                print(result);
                if (result != null) {
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => const HomePage(),
                    ),
                  );
                }
              }).catchError((error) {
                print('Registration Error: $error');
              });
              setState(() {
                _isProcessing = false;
              });
            },
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: _isProcessing
                  ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.blueGrey,
                ),
              )
                  : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const <Widget>[
                  Image(
                    image: AssetImage("assets/new_images/google_logo.png"),
                    height: 30.0,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      'Continue with Google',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.blueGrey,
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      )
    );
  }
}
