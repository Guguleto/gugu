
import 'dart:ui';

class Phone{
    String? title;
    String? description;
    int? price;
    int? id;
    String? discountPercentage;
    // String? rating;
    int? stock;
    // String? brand;
    // String? category;
    List<String>? images;

    Phone({this.title, this.description, this.price, this.id});


    Phone.fromJson(Map<String, dynamic> json) {
      title = json['title'];
      description = json['description'];
      price = json['price'];
      id = json['id'];
      discountPercentage = json['discountPercentage'].toString();
      // rating = json['rating'].toString();
      stock = json['stock'];
      // brand = json['discountPercentage'];
      // category = json['category'];
      images = List<String>.from(json['images']);
    }


    Map<String, Object?> toJson(){
        final Map<String, dynamic> data = <String, dynamic>{};
        data['title'] = title;
        data['description'] = description;
        data['price'] = price;
        data['id'] = id;
        data['discountPercentage'] = discountPercentage;
        // data['rating'] = rating;
        data['stock'] = stock;
        // data['brand'] = brand;
        // data['category'] = category;
        data['images'] = images;
        return data;
    }

    
    
}
