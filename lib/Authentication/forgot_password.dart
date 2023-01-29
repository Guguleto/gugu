import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gugu/Authentication/utils.dart';

import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);


  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose(){
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text("Reset Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Receive email to\n reset your password",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20,),
            TextFormField(
              controller: emailController,
              cursorColor: Colors.blueAccent,
              textInputAction: TextInputAction.done,
              decoration: InputDecoration(labelText: "Email"),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email)=>
              email != null && !EmailValidator.validate(email)
                  ? 'Enter a valid email': null,
            ),
            SizedBox(height: 20,),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                maximumSize: Size.fromHeight(50),
              ),
              icon: Icon(Icons.email_outlined),
              label: Text("Reset Password",
                  style: TextStyle(fontSize: 24)),
              onPressed: resetPassword,
            ),
            SizedBox(height: 24,),
            TextButton.icon(
                onPressed: ()=> FirebaseAuth.instance.signOut(),
                icon: Icon(Icons.arrow_back),
            label: Text("Back to Sign In"),
            ),

          ],
        ),
      ),
    );
    Future resetPassword() async{
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context)=>
              Center(
                child: CircularProgressIndicator(),
              )
      );

      try {
        await FirebaseAuth.instance
            .sendPasswordResetEmail(email: emailController.text.trim());
        Utils.showSnackBar("Password Reset Email Sent");
      }on FirebaseAuthException catch(e){
        print(e.toString());

        Utils.showSnackBar(e.message);
      }
      Navigator.of(context, rootNavigator: true).pop();


    }
  }

