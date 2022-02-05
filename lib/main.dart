import 'package:fyp3/screens/transactionHistory/txhistroy_test.dart';

import 'imports.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  // FirebaseAdMob.instance.initialize(appId: AdMobService().getAdMobAppId());
  runApp(MyApp());
}
// FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterError;

class Palette {
  static const MaterialColor kToDark = const MaterialColor(
    0XFF5D3FD3, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
    const <int, Color>{
      50: const Color(0xFF0A0A0A),//10%
      100: const Color(0xff472abb),//20%
      200: const Color(0xff3f26a6),//30%
      300: const Color(0xff382191),//40%
      400: const Color(0xff301c7d),//50%
      500: const Color(0xff281868),//60%
      600: const Color(0xff180e3e),//70%
      700: const Color(0xff10092a),//80%
      800: const Color(0xff080415),//90%
      900: const Color(0xff000000),//100%
    },
  );
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {

  @override
  Widget build(BuildContext context) {
    return AuthProvider(
      auth: AuthService(),
      db: FirebaseFirestore.instance,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Class.io",
        theme: ThemeData(
            brightness: Brightness.light,
            primarySwatch: Palette.kToDark,
            textTheme: TextTheme(bodyText2: GoogleFonts.quicksand(fontSize: 14.0))),
        home: HomeController(),
        routes: <String, WidgetBuilder>{
          '/home': (BuildContext context) => HomeController(),
          '/homepage': (BuildContext context) => HomePage(),
          '/transfer': (BuildContext context) => MoneyTransferPage(),
          // '/qrpage': (BuildContext context) => QrPayment(),
          '/profilepage': (BuildContext context) => ProfilePage(),
          '/qr_scan': (BuildContext context) => QRScanPage(),
          '/qr_code_gen': (BuildContext context) => QRCodeGen(),
          '/txHistorypage': (BuildContext context) => TransactionHistory(),
          '/txHistorypagetest': (BuildContext context) => txhistory_test(),


          '/signUp': (BuildContext context) => SignUpView(authFormType: AuthFormType.signUp),
          '/signIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.signIn),
          // '/anonymousSignIn': (BuildContext context) => SignUpView(authFormType: AuthFormType.anonymous),
          // '/convertUser': (BuildContext context) => SignUpView(authFormType: AuthFormType.convert),
        },
      ),
    );
  }
}

class HomeController extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final AuthService auth = AuthProvider.of(context)!.auth;
    return StreamBuilder<String>(
      stream: auth.onAuthStateChanged,
      builder: (context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          final bool signedIn = snapshot.hasData;
          return signedIn ? HomePage() : FirstView();
        }
        return Container();
      },
    );
  }
}



//--------------------------------------------------------------


// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//
//   @override
//
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/',
//       //when initial Route is given no need to add home widget for initial start point of app
//       //full app route structure
//       routes: {
//         '/':(context)=> LoginPage(),
//         '/profile':(context)=> Profile(),
//       },
//       theme: ThemeData(
//         primaryColor: Colors.white,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//     );
//   }
// }

// import 'login.dart';
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
//       overlays: [SystemUiOverlay.bottom, SystemUiOverlay.top]);
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => ApplicationState(),
//       builder: (context, _) => App(),
//     ),
//   );
// }
//
// //!! UNDER DEVELOPMENT !!
// class App extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return FutureBuilder(
//       future: Init.instance.initialize(),
//       builder: (context, AsyncSnapshot snapshot) {
//         // Show splash screen while waiting for app resources to load:
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return const MaterialApp(home: Splash());
//         } else {
//           return MaterialApp(
//             title: 'Firebase Meetup',
//             theme: ThemeData(
//               buttonTheme: Theme.of(context).buttonTheme.copyWith(
//                     highlightColor: Colors.deepPurple,
//                   ),
//               primarySwatch: Colors.deepPurple,
//               textTheme: GoogleFonts.robotoTextTheme(
//                 Theme.of(context).textTheme,
//               ),
//               visualDensity: VisualDensity.adaptivePlatformDensity,
//             ),
//             home: const HomePage(),
//           );
//         }
//       },
//     );
//   }
// }
//
//
// class LoginPageTest extends StatelessWidget {
//   const LoginPageTest({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final now = new DateTime.now();
//     String formatter = DateFormat('MMMM d, yyyy').format(now);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Fyp (Login Page)'),
//       ),
//       body: ListView(),
//       // drawer: NavigateDra,
//     );
//   }
// }
//
// class Splash extends StatelessWidget {
//   const Splash({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     bool lightMode =
//         MediaQuery.of(context).platformBrightness == Brightness.light;
//     return Scaffold(
//       backgroundColor:
//       lightMode ? const Color(0xffe1f5fe) : const Color(0xff042a49),
//       body: Center(
//           child: lightMode
//               ? Image.asset('assets/splash.png')
//               : Image.asset('assets/splash_dark.png')),
//     );
//   }
// }
//
// class Init {
//   Init._();
//   static final instance = Init._();
//
//   Future initialize() async {
//     // This is where you can initialize the resources needed by your app while
//     // the splash screen is displayed.  Remove the following example because
//     // delaying the user experience is a bad design practice!
//     await Future.delayed(const Duration(seconds: 3));
//   }
// }
// // !! !! !! !! !!
// class HomePage extends StatelessWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     final now = new DateTime.now();
//     String formatter = DateFormat('MMMM d, yyyy').format(now);
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('My Fyp (Login Page)'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Image.asset('assets/codelab.png'),
//           const SizedBox(height: 8),
//           IconAndDetail(Icons.calendar_today, 'Today: $formatter'),
//           const IconAndDetail(Icons.location_city, 'San Francisco'),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => Authentication(
//               email: appState.email,
//               loginState: appState.loginState,
//               startLoginFlow: appState.startLoginFlow,
//               verifyEmail: appState.verifyEmail,
//               signInWithEmailAndPassword: appState.signInWithEmailAndPassword,
//               cancelRegistration: appState.cancelRegistration,
//               registerAccount: appState.registerAccount,
//               signOut: appState.signOut,
//             ),
//           ),
//           const Divider(
//             height: 8,
//             thickness: 1,
//             indent: 8,
//             endIndent: 8,
//             color: Colors.grey,
//           ),
//           const Header("What we'll be doing"),
//           const Paragraph(
//             'Join us for a day full of Firebase Workshops and Pizza!',
//           ),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (appState.attendees >= 2)
//                   Paragraph('${appState.attendees} people going')
//                 else if (appState.attendees == 1)
//                   Paragraph('1 person going')
//                 else
//                   Paragraph('No one going'),
//                 if (appState.loginState == ApplicationLoginState.loggedIn) ...[
//                   YesNoSelection(
//                     state: appState.attending,
//                     onSelection: (attending) => appState.attending = attending,
//                   ),
//                   Header('Discussion'),
//                   GuestBook(
//                     addMessage: (String message) =>
//                         appState.addMessageToGuestBook(message),
//                     messages: appState.guestBookMessages,
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
