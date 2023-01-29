import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Promotions extends StatefulWidget {
  const Promotions({Key? key}) : super(key: key);

  @override
  State<Promotions> createState() => _PromotionsState();
}

class _PromotionsState extends State<Promotions> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("No Promotions Avalable",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.red))
        ],
      ),
    );
  }
}
