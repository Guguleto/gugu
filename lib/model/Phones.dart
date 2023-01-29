

import 'package:gugu/model/Phone.dart';

class Phones {
  final List<Phone> products;

  Phones({
    required this.products,
  });

  factory Phones.fromJson(Map<String, dynamic> json) {
    var list = json['products'] as List;
    List<Phone> products =
    list.map((i) => Phone.fromJson(i)).toList();
    return Phones(
      products: products,
    );
  }
}