import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:gugu/Authentication/utils.dart';

class SignUp extends StatefulWidget {
  final VoidCallback onClickedSignIn;


  const SignUp(
      {Key? key, required this.onClickedSignIn
      }) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final navigatorKey = GlobalKey<NavigatorState>();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context)=> SingleChildScrollView(
    padding: EdgeInsets.all(16.0),
    child: Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 50,),
          Image.asset("assets/images/signup.png",
            height: 200,
            width: 200,),
          SizedBox(height: 40,),
          TextFormField(
            controller: emailController,
            cursorColor: Colors.blueAccent,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Email"),
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (email)=>
              email != null && !EmailValidator.validate(email)
              ? 'Enter a valid email': null,
          ),
          SizedBox(height: 4,),
          TextFormField(
            controller: passwordController,
            cursorColor: Colors.blueAccent,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(labelText: "Password"),
            obscureText: true,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value)=>
            value != null && value.length<6
                ? 'Enter min, 6 characters': null,

          ),

          SizedBox(height: 40,),
          ElevatedButton.icon(
            icon: Icon(Icons.app_registration),
            label: Text("Sign in",
              style: TextStyle(fontSize: 24),),
            onPressed: signUp,
          ),
          SizedBox(height: 24,),
          RichText(text: TextSpan(
              style: TextStyle(color: Colors.blueAccent, fontSize: 20,
              fontWeight: FontWeight.bold),
              // text: "Already have an account ",
              children: [
                TextSpan(text: "back to Sign In",
                    recognizer: TapGestureRecognizer()
                      ..onTap = widget.onClickedSignIn,
                    style: TextStyle(
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).colorScheme.secondary
                    )
                )
              ]
          ),)
        ],
      ),
    ),
  );

  Future signUp() async{
    final isValid = formKey.currentState!.validate();
    if(!isValid) return
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context)=>
            Center(
              child: CircularProgressIndicator(),
            )
    );

    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),);

    }on FirebaseAuthException catch(e){
      print(e.toString());
      Utils.showSnackBar(e.message);
    }

    Navigator.of(context, rootNavigator: true).pop();

  }

}
