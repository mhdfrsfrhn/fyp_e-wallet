import 'package:fyp3/imports.dart';

class AuthProvider extends InheritedWidget {
  final AuthService auth;
  final db;
  final colors;

  AuthProvider({Key? key, Widget? child, required this.auth, this.db, this.colors}) : super(key: key, child: child!);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static AuthProvider? of(BuildContext context) =>
      (context.dependOnInheritedWidgetOfExactType<AuthProvider>() as AuthProvider);
}