import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginWidget extends StatefulWidget {
  @override
  _LoginWidgetState createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  void register(){
    Navigator.pushNamed(context, '/signUp');
  }

  void signUserIn() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    //try sign in
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // pop the loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        // pop the loading circle
        Navigator.pop(context);
        // WRONG EMAIL
        if (e.code == 'user-not-found') {
          // show error to user
          wrongEmailMessage();
        }

        // WRONG PASSWORD
        else if (e.code == 'wrong-password') {
          // show error to user
          wrongPasswordMessage();
        }
      }
    }

    // try {
    //   final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
    //     email: emailController.text,
    //     password: passwordController.text,
    //   );
    // } on FirebaseAuthException catch (e) {
    //   if (e.code == 'user-not-found') {
    //     print('No user found for that email.');
    //   } else if (e.code == 'wrong-password') {
    //     print('Wrong password provided for that user.');
    //   }
    // }

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
                style: TextStyle(color: Colors.white),
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
                style: TextStyle(color: Colors.white),
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
                    'welcome Back,you\'ve been missed!',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
        
                  const SizedBox(height: 50),
        
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
                        hintStyle: TextStyle(color: Colors.grey[500])),
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
                        hintStyle: TextStyle(color: Colors.grey[500])),
                  ),
        
                  const SizedBox(height: 10),
        
                  // forgot password?
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          'Forgot Password?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(170, 80),
                        textStyle: TextStyle(fontSize: 22),
                      ),
                      onPressed: signUserIn,
                      child: Text("SignIn")),
                  const SizedBox(height: 50),
        
                  //not a member , Register
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Not a member',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 4),
                      // const Text(
                      //   'register now',
                      //   style: TextStyle(
                      //     color: Colors.blue,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      TextButton(onPressed: register,
                      child: Text(
                        'register now',
                        style: TextStyle(
                          color:Colors.blue,
                          fontWeight: FontWeight.bold,                      ),
                      )
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      );
    }
  }

