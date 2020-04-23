import 'package:flutter/material.dart';
import 'pages/indexPage.dart';
import 'pages/browsePostPage.dart';
import 'pages/newPostPage.dart';

void main(){
  runApp(MaterialApp(
     
      title: 'hyper_garage_sale',
      initialRoute: '/',
      routes:{
        '/': (context) => IndexPage(),
        '/home': (context) => BrowsePostPage(),
        '/new' : (context) => NewPostPage()

      }
  ));
}