import 'package:fyp3/imports.dart';
import 'package:intl/intl.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Authentication {
  static Future<bool> authenticateWithBiometrics() async {
    final LocalAuthentication localAuthentication = LocalAuthentication();
    bool isBiometricSupported = await localAuthentication.isDeviceSupported();
    bool canCheckBiometrics = await localAuthentication.canCheckBiometrics;

    bool isAuthenticated = false;

    if (isBiometricSupported && canCheckBiometrics) {
      isAuthenticated = await localAuthentication.authenticate(
        localizedReason: 'Please complete the biometrics to proceed.',
        biometricOnly: true,
      );
    }

    return isAuthenticated;
  }
}

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<String> get onAuthStateChanged =>
      _firebaseAuth.authStateChanges().map(
            (User? user) => user!.uid,
      );

  // GET UID
  String? getCurrentUID() {
    return _firebaseAuth.currentUser!.uid;
  }

  String? getCurrentEmail() {
    return _firebaseAuth.currentUser!.email;
  }

  // GET CURRENT USER
  Future getCurrentUser() async {
    return _firebaseAuth.currentUser;
  }

  getProfileImage() {
    if (_firebaseAuth.currentUser?.photoURL != null) {
      return Image.network(_firebaseAuth.currentUser?.photoURL ?? '',
          height: 100, width: 100);
    } else {
      return Image.network('https://picsum.photos/100',
          height: 100, width: 100);
    }
  }

  // Email & Password Sign Up
  Future<String> createUserWithEmailAndPassword(String email, String password,
      String name) async {

    final authResult = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    ///Create users field
    FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user!.uid)
        .set({
      'money': 400,
      'email': email,
      'name': name,
      'userID': authResult.user!.uid
    });

    ///Create today expenses doc
    FirebaseFirestore.instance
        .collection('users')
        .doc(authResult.user!.uid)
        .collection('expenses')
        .doc(formattedDate)
        .set({
      'expenses':0
    });

    // Update the username
    await updateUserName(name, authResult.user!);
    return authResult.user!.uid;
  }

  Future updateUserName(String name, User currentUser) async {
    await currentUser.updateDisplayName(name);
    await currentUser.reload();
  }

  // Email & Password Sign In
  Future<String?> signInWithEmailAndPassword(String email,
      String password) async {
    return (await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password))
        .user!
        .uid;
  }

  // Sign Out
  signOut() async {
    return await _firebaseAuth.signOut();
  }

  // Reset Password
  Future sendPasswordResetEmail(String email) async {
    return _firebaseAuth.sendPasswordResetEmail(email: email);
  }


  // Create Anonymous User
  Future singInAnonymously() {
    return _firebaseAuth.signInAnonymously();
  }

  Future convertUserWithEmail(String email, String password,
      String name) async {
    final currentUser = _firebaseAuth.currentUser;

    final credential =
    EmailAuthProvider.credential(email: email, password: password);
    await currentUser!.linkWithCredential(credential);
    await updateUserName(name, currentUser);
  }
}

class NameValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return "Name can't be empty";
    }
    if (value.length < 2) {
      return "Name must be at least 2 characters long";
    }
    if (value.length > 50) {
      return "Name must be less than 50 characters long";
    }
    return null;
  }
}

class EmailValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return "Email can't be empty";
    }
    return null;
  }
}

class PasswordValidator {
  static String? validate(String? value) {
    if (value!.isEmpty) {
      return "Password can't be empty";
    }
    return null;
  }
}
