// import 'package:fyp3/imports.dart';
//
// class MoneyTransferPage extends StatefulWidget {
//   const MoneyTransferPage({Key? key}) : super(key: key);
//
//   @override
//   _MoneyTransferPageState createState() => _MoneyTransferPageState();
// }
//
// class _MoneyTransferPageState extends State<MoneyTransferPage> {
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         resizeToAvoidBottomInset: false,
//         backgroundColor: Theme.of(context).primaryColor,
//         body: Container(
//           height: MediaQuery.of(context).size.height,
//           child: Stack(
//             fit: StackFit.expand,
//             children: <Widget>[
//               Align(
//                 alignment: Alignment.topCenter,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: <Widget>[
//                     const Expanded(
//                       flex: 1,
//                       child: SizedBox(),
//                     ),
//                     Container(
//                       height: 55,
//                       width: 60,
//                       decoration: const BoxDecoration(
//                           image: DecorationImage(
//                               image: NetworkImage(
//                                   "https://picsum.photos/200/300.jpg"),
//                               fit: BoxFit.cover),
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     const Text(
//                       'Sending money to Geryson',
//                       style: TextStyle(
//                           fontSize: 15,
//                           fontWeight: FontWeight.w700,
//                           color: Colors.white),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     Container(
//                       width: 130,
//                       padding:
//                       const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
//                       alignment: Alignment.center,
//                       decoration: const BoxDecoration(
//                           color: LightColor.navyBlue2,
//                           borderRadius: BorderRadius.all(Radius.circular(15))),
//                       child: TextField(
//                         inputFormatters: <TextInputFormatter>[
//                           FilteringTextInputFormatter.digitsOnly
//                         ],// Only numbers can be entered
//                         keyboardType: TextInputType.number,
//                       ),
//                     ),
//                     const Expanded(
//                       flex: 2,
//                       child: SizedBox(),
//                     ),
//                     _transferButton(),
//                   ],
//                 ),
//               ),
//               const Positioned(
//                 left: -140,
//                 top: -270,
//                 child: CircleAvatar(
//                   radius: 190,
//                   backgroundColor: LightColor.lightBlue2,
//                 ),
//               ),
//               const Positioned(
//                 left: -130,
//                 top: -300,
//                 child: CircleAvatar(
//                   radius: 190,
//                   backgroundColor: LightColor.lightBlue1,
//                 ),
//               ),
//               Positioned(
//                 top: MediaQuery.of(context).size.height * .4,
//                 right: -150,
//                 child: const CircleAvatar(
//                   radius: 130,
//                   backgroundColor: LightColor.yellow2,
//                 ),
//               ),
//               Positioned(
//                 top: MediaQuery.of(context).size.height * .4,
//                 right: -180,
//                 child: const CircleAvatar(
//                   radius: 130,
//                   backgroundColor: LightColor.yellow,
//                 ),
//               ),
//               Positioned(
//                   left: 0,
//                   top: 40,
//                   child: Row(
//                     children: const <Widget>[
//                       BackButton(
//                         color: Colors.white,
//                       ),
//                       SizedBox(width: 20),
//                       TitleText(
//                         text: "Transfer",
//                         color: Colors.white,
//                       )
//                     ],
//                   )),
//               // _buttonWidget(),
//             ],
//           ),
//         ));
//   }
//
//   Align _buttonWidget() {
//     return Align(
//         alignment: Alignment.bottomCenter,
//         child: Container(
//             height: MediaQuery.of(context).size.height * .48,
//             decoration: BoxDecoration(
//                 color: Theme.of(context).backgroundColor,
//                 borderRadius: const BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40))),
//             child: Column(
//               children: <Widget>[
//                 Expanded(
//                   child: GridView.count(
//                     crossAxisCount: 3,
//                     childAspectRatio: 1.5,
//                     padding: const EdgeInsets.symmetric(horizontal: 30),
//                     children: <Widget>[
//                       _countButton(text: '1'),
//                       _countButton(text: '2'),
//                       _countButton(text: '3'),
//                       _countButton(text: '4'),
//                       _countButton(text: '5'),
//                       _countButton(text: '6'),
//                       _countButton(text: '7'),
//                       _countButton(text: '8'),
//                       _countButton(text: '9'),
//                       _icon(Icons.euro_symbol, true),
//                       _countButton(text: '0'),
//                       _icon(Icons.backspace, false),
//                     ],
//                   ),
//                 ),
//                 _transferButton()
//               ],
//             )));
//   }
//
//   Widget _transferButton() {
//     return Container(
//         margin: const EdgeInsets.only(bottom: 20),
//         padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//         decoration: const BoxDecoration(
//             color: LightColor.navyBlue2,
//             borderRadius: BorderRadius.all(Radius.circular(15))),
//         child: Wrap(
//           children: <Widget>[
//             Transform.rotate(
//               angle: 70,
//               child: const Icon(
//                 Icons.swap_calls,
//                 color: Colors.white,
//               ),
//             ),
//             const SizedBox(width: 10),
//             const TitleText(
//               text: "Transfer",
//               color: Colors.white,
//             ),
//           ],
//         ));
//   }
//
//   Widget _icon(IconData icon, bool isBackground) {
//     return Container(
//         margin: const EdgeInsets.all(10),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Container(
//               padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
//               decoration: BoxDecoration(
//                   color: isBackground
//                       ? LightColor.lightGrey
//                       : Theme.of(context).backgroundColor,
//                   borderRadius: const BorderRadius.all(Radius.circular(8))),
//               child: Icon(icon),
//             ),
//             !isBackground
//                 ? const SizedBox()
//                 : const Text(
//                     "Change",
//                     style: TextStyle(
//                         fontSize: 12,
//                         fontWeight: FontWeight.bold,
//                         color: LightColor.navyBlue2),
//                   )
//           ],
//         ));
//   }
//
//   Widget _countButton({
//     required String text,
//   }) {
//     return Material(
//         child: InkWell(
//             onTap: () {
//               print(text);
//             },
//             child: Container(
//               alignment: Alignment.center,
//               child: TitleText(
//                 text: text,
//               ),
//             )));
//   }
//
//
// }
