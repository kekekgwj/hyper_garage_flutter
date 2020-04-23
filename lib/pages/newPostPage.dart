import 'package:flutter/material.dart';
import '../model/ItemDetail.dart';
import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:path/path.dart';

class NewPostPage extends StatefulWidget {
  NewPostPage({Key key}) : super(key: key);

  NewPostState createState() => NewPostState();
}
class NewPostState extends State<NewPostPage>{
  var title ='null';
  var price = '0';
  var des   = 'null';
  var collection = 'weijie';
  final databaseReference = Firestore.instance;
  void createRecord(var title, var price,var des, var col) async {
    await databaseReference.collection(col)
        .document(title)
        .setData({
      'title': title,
      'description': des,
      'price':price
    });

  }

  var _titleController = new TextEditingController();
  var _priceController = new TextEditingController();
  var _descrController = new TextEditingController();


  File _image1;
  File _image2;
  File _image3;
  File _image4;

  FirebaseStorage _storage = FirebaseStorage.instance;

//  upload(File image) async {
//
//
//
//    String fileName = basename(image.path);
//
//
//    StorageReference reference =
//    _storage.ref().child("wj/$fileName");
//
//
//    StorageUploadTask uploadTask = reference.putFile(image);
//
//    //Snapshot of the uploading task
//    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//  }
  upload(File image) async {
//    gs://neu-spring2020.appspot.com
//    final StorageReference firebaseStorageRef =
//    FirebaseStorage.instance.ref().child('myimage.jpg');
//    final StorageUploadTask task =
//    firebaseStorageRef.putFile(_image1);

    String fileName = basename(image.path);


    StorageReference reference =
    _storage.ref().child("wj/$fileName");


    StorageUploadTask uploadTask = reference.putFile(image);

    //Snapshot of the uploading task
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
  }

  Future _getImageFromCamera1() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 80,maxHeight: 80);

    setState(() {
      _image1 = image;
    });
  }
  Future _getImageFromCamera2() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 80,maxHeight: 80);

    setState(() {
      _image2 = image;
    });
  }
  Future _getImageFromCamera3() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 80,maxHeight: 80);

    setState(() {
      _image3 = image;
    });
  }
  Future _getImageFromCamera4() async {
    var image =
    await ImagePicker.pickImage(source: ImageSource.camera, maxWidth: 80,maxHeight: 80);

    setState(() {
      _image4 = image;
    });
  }
  Future _getImageFromGallery(File _image) async {
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    final topAppBar = AppBar(
        elevation: 0.1,
        backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
        centerTitle: true,
        title: Text('New Post'),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.add),
              onPressed:(){}
          ),
          IconButton(
              icon: Icon(Icons.backspace),
              onPressed:(){
                Navigator.pop(context);
              }
          ),
          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return null;
            },
          )

        ]
    );
    return  MaterialApp(
      home: Scaffold(
          backgroundColor: Color.fromRGBO(58, 66, 86, 1.0),
          appBar: topAppBar,
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
                children: [
                  TextField(
                    controller: _titleController,
                    onChanged:(value) => title = value,
                    autofocus: false,
                    style:TextStyle(
                        fontSize: 20,
                        color: Colors.white
                    ),
                    decoration: InputDecoration(
                        hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                        hintText: 'Enter title of item',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: BorderSide(
                            color: Colors.white,
                            width: 2,
                          ),
                        ),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide(
                              color: Colors.white,
                              width: 3,
                            )
                        ),
                        prefixIcon: Padding(
                          child:IconTheme(
                            data:IconThemeData(color: Theme.of(context).primaryColor),
                            child:Icon(Icons.title),
                          ),
                          padding: EdgeInsets.only(left: 30, right: 10),
                        )
                    ),

                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child:TextField(
                          style:TextStyle(
                              fontSize: 20,
                              color: Colors.white
                          ),
                          autofocus: false,
                          controller: _priceController,
                          onChanged:(value) => price = value,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: Colors.white),
                              hintText: 'Enter price of item',
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 3,
                                  )
                              ),
                              prefixIcon: Padding(
                                child:IconTheme(
                                  data:IconThemeData(color: Theme.of(context).primaryColor),
                                  child:Icon(Icons.monetization_on),
                                ),
                                padding: EdgeInsets.only(left: 30, right: 10),
                              )
                          )
                      )
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0),
                    child: TextField(
                        style:TextStyle(
                            fontSize: 20,
                            color: Colors.white
                        ),
                        autofocus: false,
                        controller: _descrController,
                        onChanged:(value) => des = value,
                        maxLines: 5,
                        decoration: InputDecoration(
                            hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20, color: Colors.white),
                            hintText: 'Enter description of item',

                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(30),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                              ),
                            ),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30),
                                borderSide: BorderSide(
                                  color: Colors.white,
                                  width: 3,
                                )
                            ),
                            prefixIcon: Padding(
                              child:IconTheme(
                                data:IconThemeData(color: Theme.of(context).primaryColor),
                                child:Icon(Icons.text_fields),
                              ),
                              padding: EdgeInsets.only(left: 30, right: 10),
                            )
                        )
                    ),

                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15.0,right: 20.0),
                    child: Builder(builder:(context) =>
                        Align(
                            alignment: Alignment.bottomRight,
                            child: RaisedButton(
                              highlightElevation: 0.0,
                              child: Text('POST',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
                              splashColor: Colors.black,
                              highlightColor: Colors.black,
                              elevation: 0.0,
                              color: Colors.white,
                              onPressed: (){
                                createRecord(title,price,des,collection);
//                                  if(_image1 != null) upload(_image1);
//                                  if(_image2 != null) upload(_image2);
//                                  if(_image3 != null) upload(_image3);
//                                  if(_image4 != null) upload(_image4);
                                final snackBar = SnackBar(
                                  content: Text('show snackbar'),
                                  action: SnackBarAction(
                                    label:'successfully posted',
                                    onPressed : (){

                                    },
                                  ),
                                );
                                Scaffold.of(context).showSnackBar(snackBar);
                              },
                            )

                        )
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(left:10,top:20),
                      child:Column(
                        children: <Widget>[

                          Flex(
                              direction: Axis.horizontal,
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: Stack(
                                    children: <Widget>[
                                      IconButton(
                                          icon:Icon(Icons.photo_camera,color: Colors.white,),
                                          onPressed :(){
                                          _getImageFromCamera1();
                                          },

                                      ),
                                      if(_image1 != null)
                                        Image.file(
                                        _image1,fit: BoxFit.cover,)
                                    ],
                                  )
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Stack(
                                    children: <Widget>[
                                      IconButton(
                                        icon:Icon(Icons.photo_camera,color: Colors.white,),
                                        onPressed :(){
                                          _getImageFromCamera2();
                                        },

                                      ),
                                      if(_image2 != null)
                                        Image.file(
                                          _image2,fit: BoxFit.cover,)
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                ),
                                Expanded(
                                  flex: 1,
                                    child: Stack(
                                      children: <Widget>[
                                        IconButton(
                                          icon:Icon(Icons.photo_camera,color: Colors.white,),
                                          onPressed :(){
                                            _getImageFromCamera3();
                                          },

                                        ),
                                        if(_image3 != null)
                                          Image.file(
                                            _image3,fit: BoxFit.cover,)
                                      ],
                                    )

                                ),
                                Padding(
                                  padding: const EdgeInsets.only(right: 10),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Container(
                                      child: Stack(
                                        children: <Widget>[
                                          IconButton(
                                            icon:Icon(Icons.photo_camera,color: Colors.white,),
                                            onPressed :(){
                                              _getImageFromCamera4();
                                            },

                                          ),
                                          if(_image4 != null)
                                            Image.file(
                                              _image4,fit: BoxFit.cover,)
                                        ],
                                      )
                                ),
                                )

                              ]
                          )
                        ],

                      )
                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top:15.0),
//                    child:Row(
//                      children: <Widget>[
//                        Container(
//                          height: 50.0,
//
//                          color: Colors.white,
//                          child:IconButton(
//
//                            icon:Icon(Icons.photo_camera),
//                            onPressed :(){
//                              _getImageFromCamera();
//                            },
//                          ),
//                        ),
//                        Padding(
//                          padding: const EdgeInsets.only(left: 20),
//                        ),
//                        Container(
//                          height: 50.0,
//                          color: Colors.white,
//                          child:IconButton(
//
//                            icon:Icon(Icons.album),
//                            onPressed :(){
//                              _getImageFromGallery();
//                            },
//                          ),
//                        ),
//
//                      ],
//                    )
//                  ),
//                  Padding(
//                    padding: const EdgeInsets.only(top: 15.0),
//                    child: Container(
//                      height: 200,
//                      child: ListView(
//                        children: <Widget>[
//                          SizedBox(height: 10),
//                          _image == null
//                              ? Text("no image selected",style: TextStyle(color: Colors.white),)
//                              : Image.file(
//                            _image,
//                            fit: BoxFit.cover,
//                          ),
//                        ],
//                      ),
//                    )
//
//                  ),


                ]
            ),
          )


      ),

    );
  }

}
