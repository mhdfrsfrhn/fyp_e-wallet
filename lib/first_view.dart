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
                Spacer(flex:2),
                /// SizedBox(height: _height * 0.0),
                // Text(
                //   "UPM E-Wallet",
                //   style: TextStyle(fontSize: 30, color: LightColor.lightblack),
                // ),
                AutoSizeText(
                  "Berilmu Berbakti\nWith Knowledge We Serve",
                  maxLines: 3,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                ///SizedBox(height: _height * 0.2),
                Spacer(),
                Container(
                  child: Image.asset(
                    'assets/e-walletHome.png',
                    height: _height * 0.4,
                    fit: BoxFit.cover,
                  ),
                ),
                ///SizedBox(height: _height * 0.2),
                Spacer(),
                RaisedButton(
                  color: LightColor.yellow,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10.0, bottom: 10.0, left: 30.0, right: 30.0),
                    child: Text(
                      "Get Started",
                      style: TextStyle(
                        color: LightColor.black,
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
                SizedBox(height: _height * 0.02),
                FlatButton(
                  child: Text(
                    "Sign In",
                    style: TextStyle(color: Colors.black87, fontSize: 25),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/signIn');
                  },
                ),
                Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}