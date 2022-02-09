import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:fyp3/imports.dart';
import 'package:fyp3/screens/transfer/transfer_process_qr.dart';

class SendHistory_BuildItem extends StatefulWidget {
  const SendHistory_BuildItem({Key? key}) : super(key: key);

  @override
  State<SendHistory_BuildItem> createState() => _SendHistory_BuildItemState();
}

class _SendHistory_BuildItemState extends State<SendHistory_BuildItem> {
  static get user => FirebaseAuth.instance.currentUser!;
  final Query _sendHistory = FirebaseFirestore.instance
      .collection('transactionHistory')
      .orderBy('TimeDate', descending: true)
      .where('SenderEmail', isEqualTo: user.email)
      .limit(5);

  // .orderBy('DTime', descending: true);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _sendHistory
          // .where('RecipientEmail', isEqualTo: user.email)
          // .where(user.email.toString(), arrayContainsAny: ['SenderEmail', 'RecipientEmail'])
          // .where(user.email.toString(), whereIn: ["SenderEmail","RecipientEmail"])
          // .orderBy('DTime')
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: Text(
                'No Transaction\nData Found',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else if (snapshot.data!.docs.length < 1) {
          return Center(
            // alignment: Alignment.center,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 140),
              child: Text(
                'No Recent\nPayment Made',
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                textAlign: TextAlign.center,
              ),
            ),
          );
        } else {
          return Container(
            // padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs[index].get('SenderEmail').toString() ==
                    user.email) {
                  final emailValue =
                      snapshot.data!.docs[index].get('RecipientEmail');
                  return Slidable(
                    actionPane: SlidableDrawerActionPane(),
                    actionExtentRatio: 0.23,
                      secondaryActions:<Widget> [
                        IconSlideAction(
                          // An action can be bigger than the others.
                          onTap: () async {
                            bool isAuthenticated =
                            await Authentication.authenticateWithBiometrics();

                            if (isAuthenticated) {
                              var route = MaterialPageRoute(
                                  builder: (BuildContext context) => new TransferProcessQR(
                                      value: PassdataQR(
                                        email: emailValue,
                                      )));
                              Navigator.of(context).push(route);
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text('Error authenticating using Biometrics.')));
                            }
                          },
                          // backgroundColor: Color(0xFF7BC043),
                          foregroundColor: Colors.green,
                          icon: Icons.payments_rounded,
                          caption: 'Quick Pay',
                        ),
                        IconSlideAction(
                          onTap: () {_showSnackBar(context, 'Button Close pressed');},
                          // backgroundColor: Colors.transparent,
                          foregroundColor: Colors.black,
                          icon: Icons.close,
                          // label: 'Save',
                        ),
                      ],
                    child: ListTile(
                      leading: Container(
                        height: 50,
                        width: 50,
                        decoration: const BoxDecoration(
                          color: LightColor.navyBlue1,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: const Icon(Icons.account_balance_wallet_outlined,
                            color: Colors.white),
                      ),
                      contentPadding: const EdgeInsets.symmetric(),
                      title: TitleText(
                        text:
                            'To: ${snapshot.data!.docs[index].get('RecipientEmail').toString()}',
                        fontSize: 14,
                      ),
                      subtitle: Text(
                          '${snapshot.data!.docs[index].get('DTime').toString()}'),
                      trailing: Container(
                          height: 30,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: LightColor.lightGrey,
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          child: Text(
                              '-RM ${snapshot.data!.docs[index].get('AmountReceived').toString()}',
                              style: GoogleFonts.mulish(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                  color: LightColor.navyBlue2))),
                    ),
                  );
                } else {
                  return Text('');
                }
              },
            ),
          );
          // return ListView.builder(
          //   physics: ClampingScrollPhysics(),
          //     shrinkWrap: true,
          //     itemCount: snapshot.hasData ? snapshot.data!.docs.length : 0,
          //     itemBuilder: (context, index) {
          //       if (snapshot.data!.docs[index]
          //               .get('RecipientEmail')
          //               .toString() ==
          //           user.email) {
          //         return Column(
          //           children: [
          //             ListTile(
          //               leading: Container(
          //                 height: 50,
          //                 width: 50,
          //                 decoration: const BoxDecoration(
          //                   color: LightColor.navyBlue1,
          //                   borderRadius: BorderRadius.all(Radius.circular(10)),
          //                 ),
          //                 child: const Icon(Icons.account_balance_wallet_outlined,
          //                     color: Colors.white),
          //               ),
          //               contentPadding: const EdgeInsets.symmetric(),
          //               title: TitleText(
          //                 text: 'test',
          //                 fontSize: 14,
          //               ),
          //               subtitle: Text('test'),
          //               trailing: Container(
          //                   height: 30,
          //                   width: 60,
          //                   alignment: Alignment.center,
          //                   decoration: const BoxDecoration(
          //                     color: LightColor.lightGrey,
          //                     borderRadius: BorderRadius.all(Radius.circular(10)),
          //                   ),
          //                   child: Text(
          //                       '-RM ${snapshot.data!.docs[index].get('AmountReceived').toString()}',
          //                       style: GoogleFonts.mulish(
          //                           fontSize: 12,
          //                           fontWeight: FontWeight.bold,
          //                           color: LightColor.navyBlue2))),
          //             ),
          //           ],
          //         );
          //       } else {
          //         return Text('');
          //       }
          //     },
          //   );

        }
        //       },
        //     ),
        //   );
        // }
      },
    );
  }

  Scaffold _doPrintTest(BuildContext context) {
    return Scaffold(
      body: Text('test'),
    );
  }
}

void _showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(text)));
}
