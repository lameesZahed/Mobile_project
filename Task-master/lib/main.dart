import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/dashboard/dashboard_screen.dart';
import 'package:task/dashboard/nav_bar.dart';
import 'package:task/first_screens/screens/login_screen.dart';
import 'package:task/first_screens/screens/signup_screen.dart';
import 'package:task/favorite/favorite_model.dart'; // استيراد FavoriteModel
import 'package:task/profile/user_model.dart'; // استيراد UserModel
import 'package:task/add_item/item_model.dart'; // استيراد ItemModel

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => FavoriteModel()), // توفير FavoriteModel
        ChangeNotifierProvider(create: (_) => UserModel()), // توفير UserModel
        ChangeNotifierProvider(create: (_) => ItemModel()), // توفير ItemModel
      ],
      child: MyApp(isLoggedIn: isLoggedIn),
    ),
  );
}

class MyApp extends StatelessWidget {
  final bool isLoggedIn;
  const MyApp({super.key, required this.isLoggedIn});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: themeProvider.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      initialRoute: isLoggedIn ? NavBar.id : LoginScreen.id,
      routes: {
        LoginScreen.id: (context) => const LoginScreen(),
        SignUpScreen.id: (context) => const SignUpScreen(),
        NavBar.id: (context) => const NavBar(),
        DashboardScreen.id: (context) => const DashboardScreen(),
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}