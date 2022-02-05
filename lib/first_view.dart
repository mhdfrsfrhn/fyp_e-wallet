import 'package:fyp3/imports.dart';
import 'package:fyp3/widgets/custom_dialog.dart';

class FirstView extends StatelessWidget {
  final primaryColor = const Color(0xFFF0F0F0);

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        width: _width,
        height: _height,
        color: primaryColor,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: _height * 0.02),
                Text(
                  "UPM E-wallet",
                  style: TextStyle(fontSize: 22, color: Colors.black87),
                ),
                SizedBox(height: _height * 0.05),
                // AutoSizeText(
                //   "Let’s start planning your next class",
                //   maxLines: 3,
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 40,
                //     color: Colors.black87,
                //   ),
                // ),
                Container(
                  child: Image.asset(
                    'assets/upm_logo.png',
                    height: _height * 0.46,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(height: _height * 0.05),
                RaisedButton(
                  // color: Palette.kToDark,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) => CustomDialog(
                        title: "Would you like to create a free account?",
                        description:
                        "With an account, your data will be securely saved, allowing you to access it from multiple devices.",
                        primaryButtonText: "Create My Account",
                        primaryButtonRoute: "/signUp",
                        secondaryButtonText: "Maybe Later",
                        secondaryButtonRoute: "/home",
                      ),
                    );
                  },
                ),
                SizedBox(height: _height * 0.05),
                FlatButton(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}