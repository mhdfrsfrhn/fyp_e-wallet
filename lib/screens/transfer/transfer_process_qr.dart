import 'package:fyp3/services/credential.dart';
import 'package:fyp3/imports.dart';
import 'package:fyp3/screens/transfer/receipt_qr.dart';
import 'package:fyp3/services/fingerauth.dart';
import 'package:fyp3/utils/utils.dart';
import 'package:fyp3/widgets/widgets.dart';
import 'package:local_auth/auth_strings.dart';

import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class PassreceiptQR {
  final String? transactionid,
      timedate,
      recipientemail,
      recipientuid,
      recipientreference;
  final double? amount;

  const PassreceiptQR ({
    this.transactionid,
    this.timedate,
    this.recipientemail,
    this.recipientuid,
    this.recipientreference,
    this.amount,
  });
}

class TransferProcessQR extends StatefulWidget {
  final PassdataQR value;

  TransferProcessQR({Key? key, required this.value}) : super(key: key);

  @override
  _TransferProcessQRState createState() => _TransferProcessQRState();
}

class _TransferProcessQRState extends State<TransferProcessQR> {
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  final auth = FirebaseAuth.instance;
  final user = FirebaseAuth.instance.currentUser!;
  final db = FirebaseFirestore.instance;
  var transferAccountId = "";
  var data;
  LocalAuthentication _fingerauth = LocalAuthentication();
  TextEditingController _amount = TextEditingController();
  TextEditingController _reference = TextEditingController();
  var fingerAuthentication = FingerAuth();
  bool _checkBio = false;
  bool _isBioFinger = false;
  bool _isLoading = false;


  @override
  void initState() {
    super.initState();
    _checkBiometrics();
    _listBioAndFindFingerType();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          shadowColor: Colors.black,
          centerTitle: true,
          title: Text(
            'Transfer Menu',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    _textDividerTransfer(),
                    wEnterAmount(context),
                    _textDividerTransfer(),
                    wEnterReference(context),
                    _textDividerTransfer(),
                    Text('Transferring to: ${widget.value.email}'),
                    SizedBox(height: 20),
                    wSendButton(context),
                    _cancelButton(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget wSendButton(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection("users").snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          } else {
            return Container(
              child: RaisedButton(
                shape: StadiumBorder(),
                color: Colors.white,
                child: Text("Send", style: TextStyle(color: Colors.black)),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    var validatedAmount = false;
                    var transferDocId = await db
                        .collection('users')
                        .where('email', isEqualTo: widget.value.email)
                        .get()
                        .then((snapshot) {
                      return snapshot.docs[0].id;
                    }); // Read user ID of the account that you want to transfer
                    print("transferDocId: " + transferDocId);
                    await FirebaseFirestore.instance
                        .collection('users')
                        .doc(user.uid)
                        .get()
                        .then((DocumentSnapshot documentSnapshot) {
                      if (documentSnapshot.exists) {
                        data = documentSnapshot;
                        print('Document data: ${documentSnapshot.data()}');
                        if (double.parse(_amount.text.toString()) >=
                            data.get("money")) {
                          print("Don't have enough money");
                          wShowToast("You don't have enough money");
                        } else {
                          print("Amount is enough");
                          validatedAmount = true;
                        }
                      } else {
                        print('Document does not exist on the database');
                      }
                    });
                    if (validatedAmount) {

                      // if (await _startFingerAuth() != "Failed") {
                        WriteBatch batch = db.batch();
                        var transferAccount =
                        db.collection('users').doc(transferDocId);
                        batch.update(transferAccount, {
                          "money": FieldValue.increment(
                              double.parse(_amount.text.toString()))
                        });
                        print("Current user ID: " + user.uid.toString());
                        var currentAccount = db.collection('users').doc(user.uid);
                        batch.update(currentAccount, {
                          "money": FieldValue.increment(
                              double.parse(_amount.text.toString()) * -1) // 30 * -1
                        });
                        ///sending email
                        sendEmail(context, _amount.text, widget.value.email);

                        CollectionReference transactionHistoryRef =
                        FirebaseFirestore.instance
                            .collection('transactionHistory');
                        var uuid = Uuid();
                        var transactionId = uuid.v1().toString();
                        var transactionHistory = db
                            .collection('transactionHistory')
                            .doc(transactionId);
                        print("ID Transaction: " + transactionId);
                        var dateTime = DateFormat('EEE d MMM yyyy kk:mm:ss')
                            .format(DateTime.now());
                        batch.set(transactionHistory, {
                          "TimeDate": FieldValue.serverTimestamp(),
                          "DTime" : dateTime.toString(),
                          "AmountReceived": double.parse((_amount.text.toString())),
                          "RecipientEmail": widget.value.email.toString(),
                          "RecipientReference": _reference.text.toString(),
                          "RecipientUID": transferDocId.toString(),
                          "SenderEmail": user.email,
                          "SenderUID": user.uid
                        });
                        await batch.commit();
                        var route = new MaterialPageRoute(
                            builder: (BuildContext context) => new ReceiptScreenQR(
                                value: PassreceiptQR(
                                  transactionid: transactionId.toString(),
                                  timedate: dateTime.toString(),
                                  recipientemail: widget.value.email,
                                  recipientuid: transferDocId.toString(),
                                  recipientreference: _reference.text.toString(),
                                  amount: double.parse((_amount.text.toString())),
                                )));
                        Navigator.of(context).pushReplacement(route);
                      // } else {
                      //   wShowToast("Authentication Failed");
                      // }
                    }
                  }
                },
              ),
            );
          }
        });
  }

  Widget _cancelButton(BuildContext context) {
    return Container(
      child: RaisedButton(
        splashColor: Colors.grey,
        color: Colors.white,
        shape: StadiumBorder(),
        child: Text(
          'Cancel',
          style: TextStyle(color: Colors.black),
        ),
        onPressed: () async {
          await Future.delayed(const Duration(milliseconds: 100));
          wPushReplaceTo(context, HomePage());
        },
      ),
    );
  }


  ///Enter amount
  Widget wEnterAmount(BuildContext context) {
    return Container(
      width: 355,
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        inputFormatters: [

          // Allow Decimal Number With Precision of 2 Only
          FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,2}')),
        ],
        controller: _amount,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: const OutlineInputBorder(),
            labelStyle: new TextStyle(color: Colors.green),
            hintText: 'Amount',
            helperText: 'Enter the amount you would like to transfer'),
        validator: (val) => uValidator(
          value: val,
          isRequired: true,
        ),
      ),
    );
  }

  /// Recipient Reference
  Widget wEnterReference(BuildContext context) {
    return Container(
      width: 355,
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        controller: _reference,
        decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              // width: 0.0 produces a thin "hairline" border
              borderSide: const BorderSide(color: Colors.grey, width: 0.0),
            ),
            border: const OutlineInputBorder(),
            labelStyle: new TextStyle(color: Colors.green),
            hintText: 'Transfer Details',
            helperText: 'Enter a recipient Reference'),
        validator: (val) => uValidator(
          value: val,
          isRequired: true,
        ),
      ),
    );
  }

  // Biometrics
  void _checkBiometrics() async {
    try {
      final bio = await _fingerauth.canCheckBiometrics;
      setState(() {
        _checkBio = bio;
      });
      print('Biometrics = ${_checkBio}');
    } catch (e) {}
  }

  void _listBioAndFindFingerType() async {
    List<BiometricType>? _listType;
    try {
      _listType = await _fingerauth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      print(e.message);
    }

    print('List Biometrics = $_listType');

    if (_listType!.contains(BiometricType.fingerprint)) {
      setState(() {
        _isBioFinger = true;
      });
      print('Fingerprint is $_isBioFinger');
    }
  }

  Future<String?> _startFingerAuth() async {
    bool _isAuthenticated = false;
    AndroidAuthMessages _androidMsg = AndroidAuthMessages(
      signInTitle: 'Biometric authentication',
      biometricHint: '',
      cancelButton: 'Close',
    );
    try {
      _isAuthenticated = await _fingerauth.authenticate(
        localizedReason: 'Please scan your biometric or use PIN to continue',
        useErrorDialogs: true,
        stickyAuth: true,
        androidAuthStrings: _androidMsg,
      );
    } on PlatformException catch (e) {
      print(e.message);
    }

    if (_isAuthenticated) {
      return "Authenticated";
    }
    return "Failed";
  }

  Widget _textDividerTransfer() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10),
          ),
          Expanded(child: Divider()),
        ],
      ),
    );
  }
}

