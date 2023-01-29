
class Item{
  final String title;
  final String description;
  final int price;

  Item(this.title, this.description, this.price);

  Map toJason(){
    return{
      'title': title,
      'description': description,
      'price':price

    };

}
}