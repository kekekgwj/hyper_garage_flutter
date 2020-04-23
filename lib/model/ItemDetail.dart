class ItemDetail{
  String title;
  String des;
  int price;
  String imagePath;
  ItemDetail({this.title,this.des,this.price,this.imagePath});
  Map<String,dynamic> toMap(){
    return{
      'title': title,
      'des': des,
      'price':price

    };
  }
  @override
  String toString(){
    return 'itemDetail{title:$title,describe:$des,price:$price}';
  }

}