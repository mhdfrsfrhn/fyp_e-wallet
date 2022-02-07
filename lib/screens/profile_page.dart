import 'package:fyp3/imports.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
    final authData = snapshot.data;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: LightColor.navyBlue1,
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
                      flex: 2,
                      child: SizedBox(),
                    ),
                    Container(
                      width: 150.0,
                      height: 250.0,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: NetworkImage(
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
                    const SizedBox(
                      height: 20,
                    ),
                    profileMenu('${authData.displayName ?? '??'}',Icons.person),
                    profileMenu('${authData.email ?? '??'}',Icons.email_rounded),
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
                        text: "Profile",
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
///widget untuk profile menu
Widget profileMenu(text, icon){
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    child: TextButton(
      style: TextButton.styleFrom(
        primary: LightColor.black,
        padding: EdgeInsets.all(20),
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        backgroundColor: Color(0xFFF5F6F9),
      ),
      onPressed: (){},
      child: Row(
        children: [
          Icon(icon),
          SizedBox(width: 20),
          Expanded(child: Text(text)),
        ],
      ),
    ),
  );
}
