import 'package:flutter/material.dart';
import 'package:flutter_app_test1/service/dudee_service.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  void onLogin() async {
    var email = emailController.text;
    var password = passwordController.text;

    try {
      final response = await DudeeService().Login(
        email: email,
        password: password,
      );
      print("Login successful: $response");
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey, 
                      width: 1.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: passwordController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4.0),
                    borderSide: const BorderSide(
                      color: Colors.grey, 
                      width: 1.0,
                    ),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                    },
                    child: const Text('forget password?'),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: onLogin,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightBlue.shade300,

                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Log in',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 48),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.facebook, color: Colors.blue, size: 30.0),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                    },
                    child: const Text("Login with Facebook"),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                children: const <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.grey, // กำหนดสีของเส้น
                      thickness: 1, // กำหนดความหนาของเส้น
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Text("OR", style: TextStyle(color: Colors.grey)),
                  ),
                  Expanded(child: Divider(color: Colors.grey, thickness: 1)),
                ],
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Dont have an account? "),
                  TextButton(
                    onPressed: () {
                      // Navigate to sign-up screen
                    },
                    child: const Text("Sign up"),
                  ),
                ],
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
