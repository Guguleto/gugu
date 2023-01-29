import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../Authentication/auth_page.dart';
import 'home.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }else if(snapshot.hasError){
              return Center(child: Text('Oops!! Something went wrong'),);
          }else if(!snapshot.hasData){
            return AuthPage();
          }else{
            return const MyHomePage(title: 'Smart Phones');

            // return
          }
                  }
      ),
    );
  }
}




