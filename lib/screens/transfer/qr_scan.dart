import 'dart:io';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:fyp3/imports.dart';
import 'package:fyp3/screens/transfer/transfer_process_qr.dart';
import 'package:fyp3/widgets/widgets.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class QRScanPage extends StatefulWidget {
  @override
  _QRScanPageState createState() => _QRScanPageState();
}

class _QRScanPageState extends State<QRScanPage> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Barcode? barcode;
  QRViewController? controller;

  String? get currentEmail => _firebaseAuth.currentUser!.email;

  bool emailValidate = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();

    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
        child: Scaffold(
          body: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              buildQrView(context),
              Positioned(bottom: 30, child: buildControlButtons()),
              Positioned(bottom: 120, child: buildAlternative()),
            ],
          ),
        ),
      );

  Widget buildAlternative() => RichText(
        text: TextSpan(
            style: GoogleFonts.mulish(color: Colors.white, fontSize: 13),
            children: [
              TextSpan(text: 'QR code not working? Type in manually '),
              TextSpan(
                text: 'here.',
                style: TextStyle(color: Colors.blue),
                recognizer: TapGestureRecognizer()
                  ..onTap =
                      () => Navigator.pushNamed(context, '/manual_transfer'),
              ),
            ]),
      );

  Widget buildControlButtons() => Container(
        padding: EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                IconButton(
                  icon: FutureBuilder<bool?>(
                    future: controller?.getFlashStatus(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Icon(
                          snapshot.data! ? Icons.flash_on : Icons.flash_off,
                          color: Colors.white,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  onPressed: () async {
                    await controller?.toggleFlash();
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: FutureBuilder(
                    future: controller?.getCameraInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.data != null) {
                        return Icon(
                          Icons.switch_camera,
                          color: Colors.white,
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  onPressed: () async {
                    await controller?.flipCamera();
                    setState(() {});
                  },
                ),
                IconButton(
                  icon: Icon(
                    Icons.close,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                )
              ],
            ),
          ],
        ),
      );

  Widget title() => Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8), color: Colors.white24),
        child: Text(
          'QR Scanner',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );

  Widget buildQrView(BuildContext context) => QRView(
        key: qrKey,
        onQRViewCreated: onQRpop,
        overlay: QrScannerOverlayShape(
          borderColor: Colors.white,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 5,
          cutOutSize: MediaQuery.of(context).size.width * 0.8,
        ),
      );

  void onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream
        .listen((barcode) => setState(() => this.barcode = barcode));
    if (mounted) {
      controller.dispose();
      Navigator.pop(context, barcode!.code);
      wShowToast(barcode!.code!);
    }
  }

  void onQRpop(QRViewController controller) {
    DateTime? lastScan;

    setState(() => this.controller = controller);

    controller.scannedDataStream.listen(
      (barcode) async {
        final currentScan = DateTime.now();
        var receiverEmail = barcode.code.toString();

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
              controller.dispose();
              var route = new MaterialPageRoute(
                  builder: (BuildContext context) => new TransferProcessQR(
                          value: PassdataQR(
                        email: barcode.code.toString(),
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
                      "This user '${receiverEmail}' doesn't exist. Please try another QR.")));
            }
          }
        } else {
          if (lastScan == null ||
              currentScan.difference(lastScan!) > const Duration(seconds: 3)) {
            lastScan = currentScan;
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                duration: const Duration(seconds: 2),
                content: Text(
                    "You can't transfer to yourself ${currentEmail}. Please try another QR.")));
          }
        }
      },
    );
  }
}

class PassdataQR {
  final String? email;

  const PassdataQR({
    this.email,
  });
}
