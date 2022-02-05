import 'package:fyp3/imports.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeGen extends StatefulWidget {
  const QRCodeGen({Key? key}) : super(key: key);

  @override
  _QRCodeGenState createState() => _QRCodeGenState();
}

class _QRCodeGenState extends State<QRCodeGen> {
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

  Widget profileView(context, snapshot){
    final bodyHeight = MediaQuery.of(context).size.height;
        // - MediaQuery.of(context).viewInsets.bottom;
    final authData = snapshot.data;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).primaryColor,
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
                    const Expanded(
                      flex: 3,
                      child: SizedBox(),
                    ),
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
                    const SizedBox(
                      height: 20,
                    ),
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
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: TextButton(
                        style: TextButton.styleFrom(
                          // primary: kPrimaryColor,
                          padding: EdgeInsets.all(20),
                          shape:
                          RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          backgroundColor: Color(0xFFF5F6F9),
                        ),
                        onPressed: (){},
                        child: Container(
                          height: 300,
                          width: 250,
                          child: RepaintBoundary(
                            // key: globalKey,

                            ///QR GEN
                            child: QrImage(data: '${authData.email ?? '??'}', size: 0.35 * bodyHeight),
                          ),
                        ),
                        // QrImage(data: '${authData.email ?? '??'}', size: 0.35 * bodyHeight),
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
                    const Expanded(
                      flex: 2,
                      child: SizedBox(),
                    ),
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
                        text: "Receive Payment",
                        color: Colors.white,
                      )
                    ],
                  )),
              // _buttonWidget(),
            ],
          ),
        ));
  }
}


