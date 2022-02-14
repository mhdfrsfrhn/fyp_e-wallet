import 'package:fyp3/imports.dart';

class ExpensesCard extends StatefulWidget {
  const ExpensesCard({Key? key}) : super(key: key);

  @override
  State<ExpensesCard> createState() => _ExpensesCardState();
}

class _ExpensesCardState extends State<ExpensesCard> {
  Stream<DocumentSnapshot> balanceData = FirebaseFirestore.instance
      .collection('users')
      .doc(uid)
      .collection('Daily Expenses')
      .doc(formattedDate)
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: balanceData,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Text("Loading");
        }
        if (snapshot.data!.exists == false) {
          FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .collection('Daily Expenses')
              .doc(formattedDate)
              .set({
            'expenses':0
          });
          print('new daily expenses created');
        }
        return balanceCardView(context, snapshot);
      },
    );
  }

  Widget balanceCardView(BuildContext context, snapshot) {

    // print(formattedDate);
    var expenses = snapshot.data!['expenses'].toString();

    return Container(
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(40)),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * .27,
          color: LightColor.navyBlue1,
          child: Stack(
            fit: StackFit.expand,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Today Expenses,',
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: LightColor.lightNavyBlue),
                  ),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '- RM ',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.w500,
                            color: LightColor.yellow.withAlpha(200)),
                      ),
                      Text(
                        expenses,
                        style: GoogleFonts.mulish(
                            textStyle: Theme.of(context).textTheme.headline4,
                            fontSize: 35,
                            fontWeight: FontWeight.w800,
                            color: LightColor.yellow2),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              const Positioned(
                left: -170,
                top: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.lightBlue2,
                ),
              ),
              const Positioned(
                left: -160,
                top: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.lightBlue1,
                ),
              ),
              const Positioned(
                right: -170,
                bottom: -170,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow2,
                ),
              ),
              const Positioned(
                right: -160,
                bottom: -190,
                child: CircleAvatar(
                  radius: 130,
                  backgroundColor: LightColor.yellow,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
