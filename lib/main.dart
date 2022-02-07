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
      0xfffbbd5c, // 0% comes in here, this will be color picked if no shade is selected when defining a Color property which doesn’t require a swatch.
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
        title: 'E-wallet FYP',
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