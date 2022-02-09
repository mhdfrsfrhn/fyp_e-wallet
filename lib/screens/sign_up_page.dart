import 'package:fyp3/imports.dart';
import 'package:fyp3/theme/background.dart';

// final primaryColor = const Color(0xFFF0F0F0);

enum AuthFormType { signIn, signUp, reset }

class SignUpView extends StatefulWidget {
  final AuthFormType authFormType;

  SignUpView({Key? key, required this.authFormType}) : super(key: key);

  @override
  _SignUpViewState createState() =>
      _SignUpViewState(authFormType: this.authFormType);
}

class _SignUpViewState extends State<SignUpView> {
  AuthFormType authFormType;

  @override
  void initState() {
    super.initState();
  }

  _SignUpViewState({required this.authFormType});

  final formKey = GlobalKey<FormState>();
  String? _email, _password, _name, _warning;

  void switchFormState(String state) {
    formKey.currentState!.reset();
    if (state == "signUp") {
      setState(() {
        authFormType = AuthFormType.signUp;
      });
    } else if (state == 'home') {
      Navigator.of(context).pop();
    } else {
      setState(() {
        authFormType = AuthFormType.signIn;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form!.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = AuthProvider.of(context)!.auth;
        switch (authFormType) {
          case AuthFormType.signIn:
            await auth.signInWithEmailAndPassword(_email!, _password!);
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.signUp:
            await auth.createUserWithEmailAndPassword(
                _email!, _password!, _name!);
            Navigator.of(context).pushReplacementNamed('/home');
            break;
          case AuthFormType.reset:
            await auth.sendPasswordResetEmail(_email!);
            setState(() {
              _warning = "A password reset link has been sent to $_email";
              authFormType = AuthFormType.signIn;
            });
            break;
        }
      } catch (e) {
        setState(() {
          _warning = e.toString();
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Background(
          child: Container(
            // color: primaryColor,
            color: Colors.transparent,
            height: _height,
            width: _width,
            child: SafeArea(
              child: Column(
                children: <Widget>[
                  SizedBox(height: _height * 0.25),
                  showAlert(),
                  SizedBox(height: _height * 0.015),
                  Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.symmetric(horizontal: 30),
                      child: buildHeaderText()),
                  SizedBox(height: _height * 0.02),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: buildInputs() + buildButtons(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_warning != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _warning!,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _warning = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signIn) {
      _headerText = "Sign In";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Register";
    }
    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.left,
      style: GoogleFonts.nunito(
        fontWeight: FontWeight.w600,
        fontSize: 30,
        color: LightColor.titleTextColor,
      ),
    );
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    // if were in the sign up state add name
    if ([AuthFormType.signUp].contains(authFormType)) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) => _name = value!,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }

    // add email & password
    if ([AuthFormType.signUp, AuthFormType.reset, AuthFormType.signIn]
        .contains(authFormType)) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) => _email = value!,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }

    if (authFormType != AuthFormType.reset
        // && authFormType != AuthFormType.phone
        ) {
      textFields.add(
        TextFormField(
          validator: PasswordValidator.validate,
          style: TextStyle(fontSize: 22.0),
          decoration: buildSignUpInputDecoration("Password"),
          obscureText: true,
          onSaved: (value) => _password = value!,
        ),
      );
      textFields.add(SizedBox(height: 20));
    }
    return textFields;
  }

  ///buildInputs end

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white70,
      focusColor: Colors.white,
      enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 0.05  )),
      contentPadding:
          const EdgeInsets.only(left: 14.0, bottom: 10.0, top: 10.0),
    );
  }

  List<Widget> buildButtons() {
    String _switchButtonText, _newFormState, _submitButtonText;
    bool _showForgotPassword = false;
    // bool _showSignInAnon = false;
    bool _showSocial = true;

    if (authFormType == AuthFormType.signIn) {
      _switchButtonText = "Create New Account";
      _newFormState = "signUp";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
      // _showSignInAnon = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Submit";
      _showSocial = false;
    }
    // else if (authFormType == AuthFormType.phone) {
    //   _switchButtonText = "Cancel";
    //   _newFormState = "signIn";
    //   _submitButtonText = "Continue";
    //   _showSocial = false;
    // }
    else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signIn";
      _submitButtonText = "Sign Up";
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.7,
        child: RaisedButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          color: LightColor.yellow,
          textColor: LightColor.titleTextColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              _submitButtonText,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300),
            ),
          ),
          onPressed: submit,
        ),
      ),
      showForgotPassword(_showForgotPassword),
      // showSignInAnon(_showSignInAnon),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(color: Colors.black87),
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      ),
      buildSocialIcons(_showSocial),
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.black87),
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }

  Widget buildSocialIcons(bool visible) {
    final _auth = AuthProvider.of(context)!.auth;
    return Visibility(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          // Divider(
          //   color: Colors.black87,
          // ),
          SizedBox(height: 10),
        ],
      ),
      visible: visible,
    );
  }
}
