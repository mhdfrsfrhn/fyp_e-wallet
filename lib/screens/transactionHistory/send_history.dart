import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SendHistory extends StatefulWidget {
  const SendHistory({Key? key}) : super(key: key);

  @override
  State<SendHistory> createState() => _SendHistoryState();
}

class _SendHistoryState extends State<SendHistory> {
  static get user => FirebaseAuth.instance.currentUser!;
  final Query _sendHistory = FirebaseFirestore.instance
      .collection('transactionHistory')
      .where('SenderEmail', isEqualTo: user.email)
      .orderBy('TimeDate', descending: true);
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
        } else if (snapshot.data!.docs.length < 1) {
          return Container(
            alignment: Alignment.center,
            child: Text(
              'No Transaction\nData Found',
              style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              textAlign: TextAlign.center,
            ),
          );
        } else {
          return Container(
            child: ListView.builder(
              itemCount:
              snapshot.hasData ? snapshot.data!.docs.length : 0,
              itemBuilder: (context, index) {
                if (snapshot.data!.docs[index]
                    .get('SenderEmail')
                    .toString() ==
                    user.email) {
                  return Card(
                    child: ListTile(
                      title: Text(
                          'To: ${snapshot.data!.docs[index].get('RecipientEmail').toString()}'),
                      subtitle: Text(
                          'Details: ${snapshot.data!.docs[index].get('RecipientReference').toString()}\nDate Time: ${snapshot.data!.docs[index].get('DTime').toString()}'),
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.remove,
                          color: Colors.red,
                        ),
                      ),
                      trailing: Text(
                        'RM ${snapshot.data!.docs[index].get('AmountReceived').toString()}',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  );
                } else {
                  return Text('');
                }
              },
            ),
          );
        }
      },
    );
  }
}