// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {

  final emailController = TextEditingController();
  final nameController = TextEditingController();
  final passwordController = TextEditingController();


  void signUserUp() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    // try sign in
    try {
      UserCredential result = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      User? user = result.user;
      user?.updateDisplayName(nameController.text);
      // pop the loading circle
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      Navigator.pushReplacementNamed(context, '/signIn');
    } on FirebaseAuthException catch (e) {
      // pop the loading circle
      Navigator.pop(context);
      // WRONG EMAIL
      if (e.code == 'weak-password') {
        // show error to user
        print('The password provided is too weak.');
      }

      // WRONG PASSWORD
      else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  // wrong email message popup
  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Email',
              style: TextStyle(color: Color.fromARGB(255, 7, 7, 7)),
            ),
          ),
        );
      },
    );
  }

  // wrong password message popup
  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.deepPurple,
          title: Center(
            child: Text(
              'Incorrect Password',
              style: TextStyle(color: Color.fromARGB(255, 0, 0, 0)),
            ),
          ),
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
      
                // logo
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
      
      
                const SizedBox(height: 50),
      
                //welcome Back 
      
                Text(
                  'welcome',
                  style: TextStyle(
                    color: Colors.grey[700],
                    fontSize: 16,
                  ),
                ),
      
                const SizedBox(height: 50),
      
                //
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Enter your name here',
                    hintStyle: TextStyle(color: Colors.grey[500])
                    ),
              ),
                const SizedBox(height: 25),
      
                //
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Enter your email',
                    hintStyle: TextStyle(color: Colors.grey[500])
                    ),
              ),
                const SizedBox(height: 25),
      
                //
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    enabledBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey.shade400),
                    ),
                    fillColor: Colors.grey.shade200,
                    filled: true,
                    hintText: 'Enter your password',
                    hintStyle: TextStyle(color: Colors.grey[500])
                    ),
              ),
              
                const SizedBox(height: 10),
      
                // forgot password?
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 25.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.end,
                //     children: [
                //       Text(
                //         'Forgot Password?',
                //         style: TextStyle(color: Colors.grey[600]),
                //       ),
                //     ],
                //   ),
                // ),
      
                //signup button
                const SizedBox(height: 25),
                ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(170, 80),
                  textStyle: TextStyle(fontSize: 22),
                ),
                onPressed: signUserUp,
                 child: Text(
                  "Register"
                 )
                 ),
                 const SizedBox(height: 50),
      
                 //not a member , Register
                //  Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     Text(
                //       'Not a member',
                //       style: TextStyle(
                //         color: Colors.grey[700]
                //         ),
                //     ),
                //     const SizedBox(width: 4),
                //     const Text(
                //       'register now',
                //       style: TextStyle(
                //         color: Colors.blue,
                //         fontWeight: FontWeight.bold,
                //       ),
                //     ),
                //   ],
                //  )
                
      
              ],
            ),
          ),
        ),
      ),
    );
  }
}
