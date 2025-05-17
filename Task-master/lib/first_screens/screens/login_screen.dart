import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/dashboard/nav_bar.dart';
import '../widgets/constants.dart';
import '../custom_text_field.dart';
import 'signup_screen.dart';

class LoginScreen extends StatefulWidget {
  static String id = 'loginScreen';
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  // final TextEditingController emailController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _saveLoginState(bool isLoggedIn, String name,String email) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', isLoggedIn);
    await prefs.setString('userName', name);
    await prefs.setString('Email', email);// حفظ الاسم
  }

  Future<bool> _authenticateUser(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? storedEmail = prefs.getString('userEmail');
    final String? storedPassword = prefs.getString('userPassword');

    return storedEmail == email.trim() && storedPassword == password;
  }

  void _login() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isLoading = true;
        _errorMessage = null;
      });

      final bool isAuthenticated = await _authenticateUser(
        emailController.text.trim(),
        passwordController.text,
      );

      setState(() {
        _isLoading = false;
      });

      if (isAuthenticated) {
        await _saveLoginState(true, nameController.text.trim(),emailController.text);
        Navigator.pushReplacementNamed(context, NavBar.id);
      } else {
        setState(() {
          _errorMessage = 'Invalid email or password.';
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: KMainColor,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
        children: <Widget>[
          Column(
            children: <Widget>[
              SizedBox(
                height: screenHeight * 0.25,
                child: const Image(
                  image: AssetImage('images/icons/buyicon.png'),
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Text(
                'Plantique',
                style: TextStyle(
                  fontFamily: 'Pacifico',
                  fontSize: screenWidth * 0.08,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenHeight * 0.05),
              Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
                    CustomTextField(
                      screenWidth: screenWidth,
                      hint: "Email",
                      icon: Icons.email,
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      screenWidth: screenWidth,
                      hint: "User Name",
                      icon: Icons.verified_user,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      screenWidth: screenWidth,
                      hint: "Password",
                      icon: Icons.lock,
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    _errorMessage!,
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(screenWidth * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Login'),
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, SignUpScreen.id);
                },
                child: Text(
                  'Don\'t have an account? Sign up',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: screenWidth * 0.04,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
