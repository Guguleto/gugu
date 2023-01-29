import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gugu/Authentication/utils.dart';
import 'forgot_password.dart';

class Login extends StatefulWidget {
  final VoidCallback onClickedSignUp;


  const Login(
      {Key? key, required this.onClickedSignUp
      }) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context)=> SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 50,),
        Image.asset("assets/images/login.png",
          height: 200,
          width: 200,),
        TextField(
          controller: emailController,
          cursorColor: Colors.blueAccent,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: "Email"),
        ),
        SizedBox(height: 4,),
        TextField(
          controller: passwordController,
          cursorColor: Colors.blueAccent,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(labelText: "Password"),
          obscureText: true,
        ),
        SizedBox(height: 40,),
        ElevatedButton.icon(
            icon: Icon(Icons.lock_open),
            label: Text("Sign in",
            style: TextStyle(fontSize: 24),),
            onPressed: signingIn,
        ),
        SizedBox(height: 24,),
        GestureDetector(
          child: Text(
            "Forgot Password",
            style: TextStyle(
              decoration: TextDecoration.underline,
              color: Theme.of(context).colorScheme.secondary,
              fontSize: 20
            ),
          ),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const ForgotPassword()),
          )
        ),
        SizedBox(height: 24,),
        RichText(text: TextSpan(
          style: TextStyle(color: Colors.blueAccent, fontSize: 20,
          fontWeight: FontWeight.bold),
          text: "No Account ",
          children: [
            TextSpan(text: "Sign Up",
              recognizer: TapGestureRecognizer()
                ..onTap = widget.onClickedSignUp,
              style: TextStyle(
                decoration: TextDecoration.underline,
                color: Theme.of(context).colorScheme.secondary
              )
            )
          ]
        ),
        )
      ],
    ),
  );

  Future signingIn() async{
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>
            Center(
              child: CircularProgressIndicator(),
            )
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),);
    }on FirebaseAuthException catch(e){
      print(e.toString());

      Utils.showSnackBar("Please enter a valid email");

    }
    Navigator.of(context, rootNavigator: true).pop();

  }
}
