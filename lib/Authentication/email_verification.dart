import 'dart:async';


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gugu/Authentication/utils.dart';

import '../pages/home.dart';


class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  bool canResendEmail = false;
  Timer? timer;

  @override
  void initSate(){
    super.initState();

    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if(!isEmailVerified){
      sendVerificationEmail();

      timer = Timer.periodic(
        Duration(seconds: 3),
          (_) => checkEmailVerified(),
      );
    }
  }

  @override
  void dispose(){
  timer?.cancel();
  super.dispose();
  }

  Future checkEmailVerified()async{
    await FirebaseAuth.instance.currentUser!.reload();
    try{
      setState(() {
        isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

      });
      if(isEmailVerified)timer?.cancel();
    }on FirebaseAuthException catch (e){
      Utils.showSnackBar(e.toString());
    }
  }

  Future sendVerificationEmail() async{
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();

      setState(() => canResendEmail= false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail= true);

    } on FirebaseAuthException catch (e){
      Utils.showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const MyHomePage(title: 'Lifts'):
      Scaffold(
        appBar: AppBar(
          title: Text("Verify Email"),
        ),
        body: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("A verification Email Has been sent to your emial",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,),
              SizedBox(height: 24,),
              ElevatedButton.icon(
                  onPressed: canResendEmail? sendVerificationEmail:null,
                  icon: Icon(Icons.email, size: 32,),
                  label: Text("Resend email",
                    style: TextStyle(
                      fontSize: 24),
                    ),
              ),
              SizedBox(height: 24,),
              TextButton(
                  onPressed: ()=> FirebaseAuth.instance.signOut(),
                  child: Text("Cancel",
                  style: TextStyle(fontSize: 24),),
              ),
            ],
          ),
        ),
      );
      
}
