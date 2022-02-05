import 'package:fyp3/imports.dart';

// import 'package:fyp2/src/widgets/bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // static String? get uid => FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final bc = Provider.of<Blockchain>(context);
    // var userName;
    // bc.name == null? userName='': userName = bc.name;
    return FutureBuilder(
      future: AuthProvider.of(context)!.auth.getCurrentUser(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return homeView(context, snapshot);
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }

  Widget homeView(context, snapshot) {
    final authData = snapshot.data;
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        title:   RichText(
          text: TextSpan(
            style: TextStyle(color: Colors.black),
            children: <TextSpan>[
              TextSpan(text: 'Zwallet | ', style: GoogleFonts.quicksand(fontSize: 20.0)),
              TextSpan(text: 'by farrriso ', style: GoogleFonts.quicksand(fontSize: 14.0, color: Colors.grey)),
              TextSpan(text: '& ahmaddnazrii', style: GoogleFonts.quicksand(fontSize: 14.0, color: Colors.grey))
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        foregroundColor: Colors.black,
      ),
      // bottomNavigationBar: BottomNavigation(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 35),
                Row(
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        Navigator.pushNamed(context, '/profilepage');
                      },
                      child: const CircleAvatar(
                        backgroundImage:
                            NetworkImage("https://picsum.photos/200/300.jpg"),
                      ),
                    ),
                    const SizedBox(width: 15),
                    _nameText('Hello, ${authData.displayName ?? '??'}'),
                    // Text(
                    //     userName,
                    //     style: GoogleFonts.mulish(
                    //         fontSize: 18,
                    //         fontWeight: FontWeight.w600,
                    //         color: LightColor.navyBlue2)),
                    const Expanded(
                      child: SizedBox(),
                    ),
                    GestureDetector(
                      onTap: () {
                        showAlertDialog(context);
                        // AuthProvider.of(context)!.auth.signOut();
                        // Navigator.of(context).pushReplacementNamed('/signIn');
                      },
                      child: Icon(
                        Icons.logout,
                        color: Theme.of(context).iconTheme.color,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                const TitleText(text: "My wallet"),
                const SizedBox(
                  height: 20,
                ),
                const BalanceCard(),
                const SizedBox(
                  height: 50,
                ),
                const TitleText(
                  text: "Operations",
                ),
                const SizedBox(
                  height: 10,
                ),
                _operationsWidget(),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const TitleText(
                      text: "Transactions",
                    ),
                    GestureDetector(
                        child: const TitleText(
                          fontSize: 10,
                          text: "See all",
                        ),
                        onTap: () {
                          Navigator.pushNamed(context, '/txHistorypagetest');
                        }),
                  ],
                ),
                _transectionList(),
                const SizedBox(
                  height: 20,
                ),
                Divider(thickness: 2),
                Center(
                    child: Text('@Z-Wallet beta 1.0',
                        style: TextStyle(color: Colors.grey))),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget _appBar() {
  //   return Row(
  //     children: <Widget>[
  //       GestureDetector(
  //         onTap: () {
  //           ;
  //         },
  //         child: const CircleAvatar(
  //           backgroundImage: NetworkImage("https://picsum.photos/200/300.jpg"),
  //         ),
  //       ),
  //       const SizedBox(width: 15),
  //       const TitleText(text: "Hello, "),
  //       Text('Janth,',
  //           style: GoogleFonts.mulish(
  //               fontSize: 18,
  //               fontWeight: FontWeight.w600,
  //               color: LightColor.navyBlue2)),
  //       const Expanded(
  //         child: SizedBox(),
  //       ),
  //       // Icon(
  //       //   Icons.short_text,
  //       //   color: Theme.of(context).iconTheme.color,
  //       // ),
  //     ],
  //   );
  // }
  Widget _nameText(text) {
    return Text(text,
        style: GoogleFonts.mulish(
            fontSize: 18,
            fontWeight: FontWeight.w800,
            color: LightColor.navyBlue2));
  }

  Widget _operationsWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: <Widget>[
        _icon(
          icon: Icons.transfer_within_a_station,
          text: "Transfer",
          onTap: () {
            Navigator.pushNamed(context, '/qr_scan');
          },
        ),
        // _icon(Icons.phone, "Airtime"),
        _icon(
          icon: Icons.history,
          text: "Transaction History",
          onTap: () {
            Navigator.pushNamed(context, '/txHistorypagetest');
          },
        ),
        // _icon(Icons.payment, "Pay Bills"),
        // _icon(
        //   icon: Icons.payment,
        //   text: "Pay Bills",
        //   onTap: () {
        //     Navigator.pushNamed(context, '/transfer');
        //   },
        // ),
        // _icon(Icons.code, "Qr Pay"),
        _icon(
          icon: Icons.code,
          text: "QR Pay",
          onTap: () {
            Navigator.pushNamed(context, '/qr_code_gen');
          },
        ),
      ],
    );
  }

  Widget _icon(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: onTap,
          child: Container(
            height: 80,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color(0xfff3f3f3),
                      offset: Offset(5, 5),
                      blurRadius: 10)
                ]),
            child: Icon(icon),
          ),
        ),
        Text(text,
            style: GoogleFonts.mulish(
                textStyle: Theme.of(context).textTheme.headline4,
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: const Color(0xff76797e))),
      ],
    );
  }

  Widget _transectionList() {
    return Column(
      children: <Widget>[
        _transaction("Flight Ticket", "23 Feb 2020"),
        _transaction("Electricity Bill", "25 Feb 2020"),
        _transaction("Flight Ticket", "03 Mar 2020"),
      ],
    );
  }

  Widget _transaction(String text, String time) {
    return ListTile(
      leading: Container(
        height: 50,
        width: 50,
        decoration: const BoxDecoration(
          color: LightColor.navyBlue1,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: const Icon(Icons.hd, color: Colors.white),
      ),
      contentPadding: const EdgeInsets.symmetric(),
      title: TitleText(
        text: text,
        fontSize: 14,
      ),
      subtitle: Text(time),
      trailing: Container(
          height: 30,
          width: 60,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: LightColor.lightGrey,
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          child: Text('-20 MLR',
              style: GoogleFonts.mulish(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: LightColor.navyBlue2))),
    );
  }
}
