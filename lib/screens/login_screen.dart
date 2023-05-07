import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 70),

              child: Image.network(
                'https://res.cloudinary.com/dhncrtnjp/image/upload/v1671578622/Privacy_policy-rafiki_qq9lka.png',
                //width: 300,
                height: 150,
                fit: BoxFit.cover,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Email',
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: TextField(
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(90.0),
                  ),
                  labelText: 'Password',
                ),
              ),
            ),
            Container(
                height: 80,
                padding: const EdgeInsets.all(20),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                  ),
                  child: const Text('Se Connecter'),
                  onPressed: signIn,
                )),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }
}
