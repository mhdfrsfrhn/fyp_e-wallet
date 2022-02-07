import 'package:fyp3/imports.dart';
import 'package:fyp3/screens/transactionHistory/receive_history.dart';
import 'package:fyp3/screens/transactionHistory/send_history.dart';

class txhistory_test extends StatefulWidget {
  @override
  _txhistory_testState createState() => _txhistory_testState();
}

class _txhistory_testState extends State<txhistory_test> {
  // Card topArea() => Card(
  //   margin: EdgeInsets.all(10.0),
  //   elevation: 1.0,
  //   shape: RoundedRectangleBorder(
  //       borderRadius: BorderRadius.all(Radius.circular(50.0))),
  //   child: Container(
  //       decoration: BoxDecoration(
  //           gradient: RadialGradient(
  //               colors: [Color(0xFF015FFF), Color(0xFF015FFF)])),
  //       padding: EdgeInsets.all(5.0),
  //       // color: Color(0xFF015FFF),
  //       child: Column(
  //         children: <Widget>[
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //             children: <Widget>[
  //               IconButton(
  //                 icon: Icon(
  //                   Icons.arrow_back,
  //                   color: Colors.white,
  //                 ),
  //                 onPressed: () {},
  //               ),
  //               Text("Savings",
  //                   style: TextStyle(color: Colors.white, fontSize: 20.0)),
  //               IconButton(
  //                 icon: Icon(
  //                   Icons.arrow_forward,
  //                   color: Colors.white,
  //                 ),
  //                 onPressed: () {},
  //               )
  //             ],
  //           ),
  //           Center(
  //             child: Padding(
  //               padding: EdgeInsets.all(5.0),
  //               child: Text(r"$ 95,940.00",
  //                   style: TextStyle(color: Colors.white, fontSize: 24.0)),
  //             ),
  //           ),
  //           SizedBox(height: 35.0),
  //         ],
  //       )),
  // );


  ///main ui
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultTabController(
          length: 2,
          initialIndex: 0,
          child:
          Scaffold(
            appBar: AppBar(
              foregroundColor: Colors.white,
              backgroundColor: LightColor.navyBlue1,
              title: const Text('Transaction History'),
              centerTitle: true,
              bottom: const TabBar(
                unselectedLabelColor: LightColor.darkgrey,
                labelColor: Colors.white,
                indicatorColor: LightColor.yellow,
                tabs: [
                  Tab(
                    // icon: Icon(MdiIcons.remoteTv),
                    text: "Paid",
                  ),
                  Tab(
                    // icon: Icon(MdiIcons.remoteTv),
                    text: "Received",
                  ),
                ],
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child:
              const TabBarView(
                children: [
                  SendHistory(),
                  ReceiveHistory(),
                ],
              ),
            ),
          ),
        ),

    );
  }
}