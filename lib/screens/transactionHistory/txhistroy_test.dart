import 'package:fyp3/imports.dart';
import 'package:fyp3/screens/transactionHistory/receive_history.dart';
import 'package:fyp3/screens/transactionHistory/send_history.dart';

class txhistory_test extends StatefulWidget {
  @override
  _txhistory_testState createState() => _txhistory_testState();
}

class _txhistory_testState extends State<txhistory_test> {

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