import 'package:fyp3/imports.dart';

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = ElevatedButton(
    child: Text("Cancel"),
    onPressed:  () {Navigator.of(context).pop();},
  );
  Widget continueButton = ElevatedButton(
    child: Text("Continue"),
    onPressed:  () {AuthProvider.of(context)!.auth.signOut();
    Navigator.of(context).pushReplacementNamed('/signIn');}

  );
  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logging out..."),
    content: Text("Would you like to seriously logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );
  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}