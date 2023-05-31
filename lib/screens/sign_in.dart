import 'package:dehas_admin/services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:dehas_admin/screens/loading.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});
  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;

  final TextEditingController _emailTextEditingController =
      TextEditingController();
  final TextEditingController _passwordTextEditingController =
      TextEditingController();
  String? errorMessage;

  Future signInWithEmailAndPassword() async {
    try {
      await _auth.signInWithEmailAndPassword(_emailTextEditingController.text,
          _passwordTextEditingController.text);
    } on FirebaseAuthException catch (e) {
      errorMessage = e.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? const Loading()
        : Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('assets/back.png'),
                        fit: BoxFit.cover)),
                padding: const EdgeInsets.symmetric(
                    vertical: 20.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/logo.png'),
                    const Text(
                      'D.E.H.A.S',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.white54,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            const SizedBox(height: 20.0),
                            TextFormField(
                              decoration:
                                  const InputDecoration(labelText: 'Email'),
                              validator: (val) =>
                                  val!.isEmpty ? 'Enter an email' : null,
                              controller: _emailTextEditingController,
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              obscureText: true,
                              decoration:
                                  const InputDecoration(labelText: 'Password'),
                              validator: (val) => val!.length < 6
                                  ? 'Enter a password 6+ chars long'
                                  : null,
                              controller: _passwordTextEditingController,
                            ),
                            const SizedBox(height: 20.0),
                            ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(fontSize: 20),
                                    minimumSize: const Size.fromHeight(50),
                                    backgroundColor:
                                        Colors.blue[800]!.withOpacity(.9)),
                                child: const Text('Sign In'),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    setState(() {
                                      loading = true;
                                    });
                                    dynamic result =
                                        await signInWithEmailAndPassword();
                                    if (result == null) {
                                      setState(() {
                                        // errorMessage = 'Invalid Credentials';
                                        loading = false;
                                      });
                                    }
                                  }
                                }),
                            errorMessage != null
                                ? const SizedBox(height: 12.0)
                                : const SizedBox(),
                            Text(
                              errorMessage ?? '',
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14.0),
                            ),
                            errorMessage != null
                                ? const SizedBox(height: 12.0)
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          );
  }
}
