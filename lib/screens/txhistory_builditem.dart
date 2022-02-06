import 'package:fyp3/imports.dart';

class SendHistory_BuildItem extends StatefulWidget {
  const SendHistory_BuildItem({Key? key}) : super(key: key);

  @override
  State<SendHistory_BuildItem> createState() => _SendHistory_BuildItemState();
}

class _SendHistory_BuildItemState extends State<SendHistory_BuildItem> {
  static get user => FirebaseAuth.instance.currentUser!;
  final Query _sendHistory = FirebaseFirestore.instance
      .collection('transactionHistory')
      .where('SenderEmail', isEqualTo: user.email);

  // .orderBy('DTime', descending: true);
  final auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _sendHistory.snapshots(),
      // .where('RecipientEmail', isEqualTo: user.email)
      // .where(user.email.toString(), arrayContainsAny: ['SenderEmail', 'RecipientEmail'])
      // .where(user.email.toString(), whereIn: ["SenderEmail","RecipientEmail"])
      // .orderBy('DTime', descending: true)
      //     .snapshots(),
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
        }
        else {
          return Container(
            // padding: EdgeInsets.all(8),
            child: ListView.builder(
              itemCount:
              snapshot.hasData ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs[index]
                    .get('SenderEmail')
                    .toString() ==
                    user.email) {
                  return ListTile(
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: const BoxDecoration(
                        color: LightColor.navyBlue1,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      child: const Icon(Icons.account_balance_wallet_outlined, color: Colors.white),
                    ),
                    contentPadding: const EdgeInsets.symmetric(),
                    title: TitleText(
                      text: 'To: ${snapshot.data!.docs[index].get('RecipientEmail').toString()}',
                      fontSize: 14,
                    ),
                    subtitle: Text('${snapshot.data!.docs[index].get('DTime').toString()}'),
                    trailing: Container(
                        height: 30,
                        width: 60,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          color: LightColor.lightGrey,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text('-RM ${snapshot.data!.docs[index].get('AmountReceived').toString()}',
                            style: GoogleFonts.mulish(
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                color: LightColor.navyBlue2))),
                  );
                  // return Card(
                  //   child: ListTile(
                  //     title: Text(
                  //         'To: ${snapshot.data!.docs[index].get('RecipientEmail').toString()}'),
                  //     subtitle: Text(
                  //         'Details: ${snapshot.data!.docs[index].get('RecipientReference').toString()}\nDate Time: ${snapshot.data!.docs[index].get('DTime').toString()}'),
                  //     leading: CircleAvatar(
                  //       backgroundColor: Colors.white,
                  //       child: Icon(
                  //         Icons.remove,
                  //         color: Colors.red,
                  //       ),
                  //     ),
                  //     trailing: Text(
                  //       'RM ${snapshot.data!.docs[index].get('AmountReceived').toString()}',
                  //       style: TextStyle(color: Colors.red),
                  //     ),
                  //   ),
                  // );
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
}
