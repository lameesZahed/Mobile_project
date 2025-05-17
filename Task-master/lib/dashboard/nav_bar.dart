import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart'; // استيراد shared_preferences
import 'package:task/dashboard/dashboard_screen.dart';
import 'package:task/profile/profile_page/profile_page.dart';
import 'package:task/qoute/qoute_screen.dart';

import '../favorite/favorite_screen.dart';
import '../first_screens/screens/login_screen.dart'; // استيراد شاشة تسجيل الدخول

class NavBar extends StatefulWidget {
  static const String id = 'navBarScreen';
  const NavBar({super.key});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _selectedIndex = 0;

  // دالة لمسح حالة تسجيل الدخول والانتقال إلى شاشة تسجيل الدخول
  Future<void> _logout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // إزالة علامة تسجيل الدخول
    Navigator.pushReplacementNamed(context, LoginScreen.id); // الانتقال إلى شاشة تسجيل الدخول
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("My App"), // يمكنك تغيير العنوان
        actions: [
          IconButton(
            icon: const Icon(Icons.logout), // أيقونة تسجيل الخروج
            onPressed: () {
              _logout(context); // استدعاء دالة تسجيل الخروج عند الضغط
            },
          ),
        ],
      ),
      body: [
        DashboardScreen(),
        QouteScreen(),
        FavoriteScreen(),
        ProfilePage(),
      ][_selectedIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.dashboard), label: "Dashboard"),
          NavigationDestination(icon: Icon(Icons.format_quote), label: "Quote"),
          NavigationDestination(icon: Icon(Icons.favorite), label: "Favorite"),
          NavigationDestination(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}