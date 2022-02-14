import 'package:fyp3/imports.dart';

import '../../utils/utils.dart';
import '../transfer/transfer_process_qr.dart';

class ManualTransfer extends StatefulWidget {
  const ManualTransfer({Key? key}) : super(key: key);

  @override
  _ManualTransferState createState() => _ManualTransferState();
}

class _ManualTransferState extends State<ManualTransfer> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  TextEditingController _manualEmail = TextEditingController();

  String? get currentEmail => _firebaseAuth.currentUser!.email;

  bool emailValidate = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthProvider.of(context)!.auth.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return profileView(context, snapshot);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget profileView(context, snapshot) {
    // final bodyHeight = MediaQuery.of(context).size.height;
    // // - MediaQuery.of(context).viewInsets.bottom;
    // final authData = snapshot.data;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: LightColor.lightNavyBlue,
        body: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                right: -150,
                child: const CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow2,
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height * .4,
                right: -180,
                child: const CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow,
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Spacer(),
                    Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: new NetworkImage(
                                "https://picsum.photos/200/300.jpg")),
                      ),
                    ),
                    // Container(
                    //   height: 55,
                    //   width: 60,
                    //   decoration: const BoxDecoration(
                    //       image: DecorationImage(
                    //           image: NetworkImage(
                    //               "https://picsum.photos/200/300.jpg"),
                    //           fit: BoxFit.cover),
                    //       borderRadius: BorderRadius.all(Radius.circular(15))),
                    // ),
                    //
                    // const Text(
                    //   'Sending money to Geryson',
                    //   style: TextStyle(
                    //       fontSize: 15,
                    //       fontWeight: FontWeight.w700,
                    //       color: Colors.white),
                    // ),
                    // const SizedBox(
                    //   height: 20,
                    // ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 15),
                  child: Container(
                    width: 355,
                    padding: EdgeInsets.only(bottom: 20),
                    child: TextFormField(
                      controller: _manualEmail,
                      decoration: InputDecoration(
                        labelStyle: TextStyle(color: Colors.grey),
                        filled: true,
                          fillColor: Colors.white,
                          enabledBorder: OutlineInputBorder(
                            // width: 0.0 produces a thin "hairline" border
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(color: Colors.grey, width: 0.0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(
                              color: LightColor.lightBlue1,
                              width: 2.0,
                            ),
                          ),
                          border: OutlineInputBorder(),
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          labelText: "Receiver's Email",
                          helperText: "Type in receiver's email"),
                      validator: (val) => uValidator(
                        value: val,
                        isRequired: true,
                      ),
                    ),
                  ),
                ),
                    // Container(
                    //   width: 130,
                    //   padding: const EdgeInsets.symmetric(
                    //       horizontal: 30, vertical: 15),
                    //   alignment: Alignment.center,
                    //   decoration: const BoxDecoration(
                    //       color: LightColor.navyBlue2,
                    //       borderRadius: BorderRadius.all(Radius.circular(15))),
                    //   child: TextField(
                    //     inputFormatters: <TextInputFormatter>[
                    //       FilteringTextInputFormatter.digitsOnly
                    //     ], // Only numbers can be entered
                    //     keyboardType: TextInputType.number,
                    //   ),
                    // ),
                    _transferButton(context, _manualEmail.text.toString()),
                    Spacer(),

                    /// _transferButton(),
                  ],
                ),
              ),
              const Positioned(
                left: -140,
                top: -270,
                child: CircleAvatar(
                  radius: 190,
                  backgroundColor: LightColor.lightBlue2,
                ),
              ),
              const Positioned(
                left: -130,
                top: -300,
                child: CircleAvatar(
                  radius: 190,
                  backgroundColor: LightColor.lightBlue1,
                ),
              ),
              Positioned(
                  left: 0,
                  top: 40,
                  child: Row(
                    children: const <Widget>[
                      BackButton(
                        color: Colors.white,
                      ),
                      SizedBox(width: 20),
                      TitleText(
                        text: "Manual Transfer",
                        color: Colors.white,
                      )
                    ],
                  )),
              // _buttonWidget(),
            ],
          ),
        ));
  }
  Widget _transferButton(context, manualEmail) {
    DateTime? lastScan;
    return GestureDetector(
      onTap: () async {
        final currentScan = DateTime.now();
        var receiverEmail = manualEmail;

        // Future<bool> doesEmailExist(String receiverEmail) async {
        //   final QuerySnapshot result = await FirebaseFirestore.instance
        //       .collection('users')
        //       .where('email', isEqualTo: receiverEmail)
        //       .limit(1)
        //       .get();
        //   final List<DocumentSnapshot> documents = result.docs;
        //   if (documents.length == 1) {
        //     print('email exist');
        //     return true;
        //   } else
        //     print('email doesnt exist');
        //     return false;
        // }
        await FirebaseFirestore.instance
            .collection('users')
            .where('email', isEqualTo: receiverEmail)
            .limit(1)
            .get()
            .then((value) {
          if (value.docs.isNotEmpty) {
            emailValidate = true;
            // emailValidate = true;
          }else
            emailValidate = false;
        });

        //     .then((DocumentSnapshot documentSnapshot) {
        //   if (documentSnapshot.exists) {
        //     var data = documentSnapshot;
        //     if (data.get('email') == receiverEmail) {
        //       print('debug');
        //       emailValidate = true;
        //     }
        //   } else {
        //     emailValidate = false;
        //     print('debug else');
        //   }
        // });

        if (receiverEmail != currentEmail) {
          if (emailValidate == true) {
            if (mounted) {
              var route = MaterialPageRoute(
                  builder: (BuildContext context) => new TransferProcessQR(
                      value: PassdataQR(
                        email: receiverEmail,
                      )));
              Navigator.of(context).push(route);
            }
          } else {
            if (lastScan == null ||
                currentScan.difference(lastScan!) >
                    const Duration(seconds: 3)) {
              lastScan = currentScan;
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                  duration: const Duration(seconds: 2),
                  content: Text(
                      "This user '${receiverEmail}' doesn't exist. Please try another email.")));
            }
          }
        } else {
          if (lastScan == null ||
              currentScan.difference(lastScan!) > const Duration(seconds: 3)) {
            lastScan = currentScan;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(
                    "You can't transfer to yourself ${currentEmail}. Please try another email.")));
          }
        }
      },
      // {
      //
      //     var route = MaterialPageRoute(
      //         builder: (BuildContext context) => new TransferProcessQR(
      //             value: PassdataQR(
      //               email: receiverEmail,
      //             )));
      //     Navigator.of(context).push(route);
      // },


      child: Container(
          margin: EdgeInsets.only(bottom: 20),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          decoration: BoxDecoration(
              color: LightColor.navyBlue2,
              borderRadius: BorderRadius.all(Radius.circular(15))),
          child: Wrap(
            children: <Widget>[
              Transform.rotate(
                angle: 70,
                child: Icon(
                  Icons.swap_calls,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 10),
              TitleText(
                text: "Transfer",
                color: Colors.white,
              ),
            ],
          )),
    );
  }
}


