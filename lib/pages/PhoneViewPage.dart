
import 'package:badges/badges.dart' as badge;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gugu/model/Phone.dart';
import 'package:gugu/pages/myShopingCart.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../Provider/cartProvider.dart';
import '../model/Phones.dart';

class PhoneViewPage extends StatefulWidget {
  var uId;
  PhoneViewPage(this.uId);

  @override
  State<PhoneViewPage> createState() => _PhoneViewPageState();
}

class _PhoneViewPageState extends State<PhoneViewPage> {
  var uId;

  @override
  void initState() {
    super.initState();
    uId = widget.uId;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
            position: const badge.BadgePosition(
                start: 30, bottom: 30),
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
          const SizedBox(
            width: 20.0,
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder<List<Phone>>(
                future: fetchPhones(),
                builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: 1,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return SizedBox(
                          child: Column(
                              children: [
                                Image.network(snapshot.data![index].images![0]),
                                ListTile(
                                  title: Text(snapshot.data![index].title.toString()),
                                  subtitle:  Column(
                                    children: [
                                      Text(snapshot.data![index].description.toString(),
                                        style: const TextStyle(
                                            fontSize: 18
                                        ),),
                                      Text('Phone discount percentage ${snapshot.data![index].discountPercentage.toString()}%',
                                      style: const TextStyle(
                                        fontSize: 18
                                      ),),
                                      Text('Stock Left ${snapshot.data![index].discountPercentage.toString()}',
                                        style: const TextStyle(
                                            fontSize: 18
                                        ),),
                                    ],
                                  ),
                                  trailing: Text('Price ${snapshot.data![index].price.toString()}',
                                    style: const TextStyle(
                                        fontSize: 18
                                    ),),
                                ),
                                ElevatedButton(
                                    // style: ElevatedButton.styleFrom(
                                    //   primary: Colors.black,
                                    //   minimumSize: const Size.fromHeight(10), // NEW
                                    // ),
                                    onPressed: (){

                                }, child: Text("Add to cart", style: TextStyle(fontSize: 24),))
                          ]
                          )
                      );

                    },
                  );
                }else if (snapshot.hasError) {

                  return Text('error = ${snapshot.error}');
                }
                return const CircularProgressIndicator();
              }
            )
          ],
        ),
      )

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

}
