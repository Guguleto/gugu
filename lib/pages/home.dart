
import 'dart:convert';

import 'package:badges/badges.dart' as badge;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gugu/model/Phone.dart';
import 'package:gugu/pages/myShopingCart.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../Provider/cartProvider.dart';
import '../model/Phones.dart';
import 'PhoneViewPage.dart';
import 'navDrawer.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
        actions: [
          badge.Badge(

            badgeContent: Consumer<CartProvider>(
              builder: (context, value, child) {
                return Text(
                  value.getCounter().toString(),
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                );
              },
            ),
            position: const badge.BadgePosition(start: 30, bottom: 30),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyShoppingCart()));
              },
              icon: const Icon(Icons.shopping_cart),
            ),
          ),
        ElevatedButton(
            onPressed: () =>
                FirebaseAuth.instance.signOut(),
            child: Text("Sign Out")),
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder<List<Phone>>(
                future: fetchPhones(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {

                        return SizedBox(
                          width: 80,
                          height: 150,
                          child: InkWell(
                            splashColor: Colors.blueGrey,
                            onTap: (){
                              var uId = snapshot.data![index].id.toString();
                             goToNextScreen(context, uId);
                            },

                            child: Card(
                              margin: EdgeInsets.all(10),
                              elevation: 30,
                              child: ListTile(
                                title: Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Text(snapshot.data![index].title.toString())),
                                subtitle: Text(snapshot.data![index].description.toString()),
                                leading: ConstrainedBox(
                                  constraints: const BoxConstraints(
                                    minWidth: 44,
                                    minHeight: 44,
                                    maxWidth: 64,
                                    maxHeight: 64,
                                  ),
                                 child: Image.network(snapshot.data![index].images![0]),),
                                trailing: Text('R ${snapshot.data![index].price.toString()}'),
                              ),
                            ),
                          ),

                        );
                      },
                    );
                  } else if (snapshot.hasError) {

                    return Text('error = ${snapshot.error}');
                  }
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
  Future<List<Phone>> fetchPhones() async {
    final response = await http.get(Uri.parse(
        'https://dummyjson.com/products/category/smartphones'));

    if (response.statusCode == 200) {
      var decode = json.decode(response.body);

      Phones phones = Phones.fromJson(decode) ;
      return phones.products;

    } else {
      throw Exception('Failed to load data');
    }
  }

  static void goToNextScreen(BuildContext context, var uId) {
    Navigator.of(context).push(new MaterialPageRoute<dynamic>(builder:
        (BuildContext context) {
      return PhoneViewPage(uId);
    },));
  }

}