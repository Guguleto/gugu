import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PurchaseHistory extends StatefulWidget {
  const PurchaseHistory({Key? key}) : super(key: key);

  @override
  State<PurchaseHistory> createState() => _PurchaseHistoryState();
}

class _PurchaseHistoryState extends State<PurchaseHistory> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text("No history",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24, color: Colors.red))
        ],
      ),
    );
  }
}
