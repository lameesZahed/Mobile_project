import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task/first_screens/screens/login_screen.dart';
import '../widgets/constants.dart';
import '../custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  static String id = 'signUpScreen';
  const SignUpScreen({super.key});

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String? _errorMessage;

  Future<void> _saveUserData(String email, String password) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('userEmail', email);
    await prefs.setString('userPassword', password);
    await prefs.setBool('isLoggedIn', false); // يبدأ غير مسجل الدخول
  }

  Future<bool> _signUpUser(String name, String email, String password) async {
    await Future.delayed(const Duration(seconds: 2));
    return true;
  }

  void _signUp() async {
    if (_formKey.currentState?.validate() ?? false) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Passwords do not match')),
        );
      } else {
        setState(() {
          _isLoading = true;
          _errorMessage = null;
        });

        final String name = nameController.text.trim();
        final String email = emailController.text.trim();
        final String password = passwordController.text;

        final bool signUpSuccessful = await _signUpUser(name, email, password);

        setState(() {
          _isLoading = false;
        });

        if (signUpSuccessful) {
          await _saveUserData(email, password);
          Navigator.pushReplacementNamed(context, LoginScreen.id); // ✅ نروح لـ Login بعد التسجيل
        } else {
          setState(() {
            _errorMessage = 'Failed to create account. Please try again.';
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(_errorMessage!)),
          );
        }
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
                      hint: "Full Name",
                      icon: Icons.person,
                      controller: nameController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      screenWidth: screenWidth,
                      hint: "Email",
                      icon: Icons.email,
                      controller: emailController,
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
                      hint: "Password",
                      icon: Icons.lock,
                      controller: passwordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: screenHeight * 0.02),
                    CustomTextField(
                      screenWidth: screenWidth,
                      hint: "Confirm Password",
                      icon: Icons.lock_outline,
                      controller: confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != passwordController.text) {
                          return 'Passwords do not match';
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
                onPressed: _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(screenWidth * 0.8, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Sign Up'),
              ),
              SizedBox(height: screenHeight * 0.02),
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                },
                child: Text(
                  'Already have an account? Login',
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
