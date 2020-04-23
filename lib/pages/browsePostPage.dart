import '../model/ItemDetail.dart';
import 'package:flutter/material.dart';
import 'detailPage.dart';
import 'newPostPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class BrowsePostPage extends StatefulWidget{
  BrowsePostPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _browserPostPageState createState() => _browserPostPageState();
}

class _browserPostPageState extends State<BrowsePostPage>{

  List items;

  @override
  void initState() {
    items = getItems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


//    final makeBody = Container(
//      // decoration: BoxDecoration(color: Color.fromRGBO(58, 66, 86, 1.0)),
//      child: ListView.builder(
//        scrollDirection: Axis.vertical,
//        shrinkWrap: true,
//        itemCount: items.length,
//        itemBuilder: (BuildContext context, int index) {
//          return makeCard(items[index]);
//        },
//      ),
//    );
    final makeBottom = Container(
      height: 55.0,
      child: BottomAppBar(
        color: Color.fromRGBO(58, 66, 86, 1.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(Icons.home, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.blur_on, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.hotel, color: Colors.white),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.account_box, color: Colors.white),
              onPressed: () {},
            )
          ],
        ),
      ),
    );
    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      centerTitle: true,
      title: Text('Item List'),
      actions: <Widget>[
        IconButton(
          icon: Icon(Icons.list),
          onPressed: () {},
        )
      ],
    );

    return Scaffold(
      backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
      appBar: topAppBar,
      body: MessagesStream(),
      bottomNavigationBar: makeBottom,
        floatingActionButton: new FloatingActionButton(
            child:const Icon(Icons.arrow_forward),
            shape: new CircleBorder(),
            foregroundColor: Color.fromRGBO(58, 66, 86, 0.7),
            backgroundColor: Colors.white,
            onPressed: (){
              Navigator.push(context,MaterialPageRoute(builder:(context) => NewPostPage()));
            }
        )
    );
  }
}
final _firestore = Firestore.instance;
class MessagesStream extends StatelessWidget {

  final List<Widget> itemList = [];
  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(ItemDetail itemDetail) => ListTile(
      contentPadding:
      EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      leading: Container(
        padding: EdgeInsets.only(right: 12.0),
        decoration: new BoxDecoration(
            border: new Border(
                right: new BorderSide(width: 1.0, color: Colors.white24))),
        child: Icon(Icons.card_membership, color: Colors.white),
      ),
      title: Text(
        itemDetail.title,
        maxLines: 1,
        softWrap: true,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
      // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

      subtitle: Row(
        children: <Widget>[
          Expanded(
              flex: 1,
              child: Container(
                // tag: 'hero',
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(itemDetail.price.toString(),style: TextStyle(color: Colors.white, fontWeight: FontWeight.normal,fontSize: 15),maxLines: 1,softWrap: true,),
                      Icon(Icons.monetization_on,size:15,color:Colors.yellow)
                    ],
                  ),
                  //child:Text(itemDetail.price.toString()+'$',style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
                ),
              )),
          Expanded(
            flex: 4,
            child: Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Text(itemDetail.des,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                    style: TextStyle(color: Colors.white,fontSize: 15),maxLines: 2)),
          )
        ],
      ),
      trailing:
      Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DetailPage(item:itemDetail)));
      },
    );

    Card makeCard(ItemDetail itemDetail) => Card(
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: makeListTile(itemDetail),
      ),
    );
    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('weijie').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.lightBlueAccent,
            ),
          );
        }
        final messages = snapshot.data.documents;
        for (var message in messages) {
          final price = message.data['price'];
          final title = message.data['title'];
          final description = message.data['description'];
//          final image_path = message.data['image_path'];
          final item = ItemDetail(
            price: price,
            title: title,
            des: description,
          );
//          itemList.add(ListTile(
//            leading: CircleAvatar(
//                backgroundImage: item.imagePath == null?
//                AssetImage('images/image.png') : NetworkImage(image_path)),
//            title: Text( "        \$" ),
//            subtitle: Text('aaaa' ),
//          ));
          itemList.add((makeCard(item)));
        }
        return ListView(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          children: itemList,
        );
      },
    );
  }
}

List getItems() {
  return [
    ItemDetail(
        title: "Nintendo Switch with Neon Blue and Neon Red",
        des: "Play your way with the Nintendo Switch gaming system. Whether you’re at home or on the go, solo or with friends, the Nintendo Switch system is designed to fit your life. Dock your Nintendo Switch to enjoy HD gaming on your TV. Heading out? Just undock your console and keep playing in handheld mode",
        price: 22,
    ),
    ItemDetail(
      title: "Introduction to Driving",
      des: "Beginner",
      price: 33,
    ),
    ItemDetail(
      title: "Introduction to Driving",
      des: "Beginner",
      price: 44,
    ),
    ItemDetail(
      title: "Introduction to Driving",
      des: "Beginner",
      price: 66,
    ),

  ];
}