import 'package:flutter/material.dart';
import 'package:hyper_garage/customWidget/customTextField.dart';
import 'package:hyper_garage/customWidget/filledButton.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:validators/validators.dart';


final FirebaseAuth _auth = FirebaseAuth.instance;

class IndexPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => indexState();
}

class indexState extends State<IndexPage>{
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = true;
  var emailController = new TextEditingController();
  var passwordController = new TextEditingController();
  String _email;
  String _password;
  void signUpWithEmail() async{
    FirebaseUser user;
    try{
      print(_email);
      print(_password);

      user = await _auth.createUserWithEmailAndPassword(email: _email, password: _password);

    }catch(e){
      print(e.toString());
    }finally{
      if(user != null){
        Navigator.of(context).pushNamed('/home');
      }else{
        AlertDialog(title: Text('warning'),content: Text('try agagin'),);
      }
    }
  }
  void signInWithEmail() async{
    FirebaseUser user;
    try{
      print(_email);
      print(_password);
      user = await _auth.signInWithEmailAndPassword(email: _email, password: _password);
    }catch(e){
      print(e.toString());
    }finally{
      if(user != null){
        Navigator.of(context).pushNamed('/home');
      }else{
        AlertDialog(title: Text('warning'),content: Text('try agagin'),);
      }
    }
  }
  void _validateRegisterInput() async{


  }
  @override
  Widget build(BuildContext context){
    return MaterialApp(theme: new ThemeData(primaryColor: Colors.black),
        home:Scaffold(
            backgroundColor: Colors.white,
            body:Stack(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.only(left: 10.0),
                    height: MediaQuery.of(context).size.height * 0.4,
                    decoration: new BoxDecoration(
                      image: new DecorationImage(
                        image: new AssetImage("images/sale.png"),
                        fit: BoxFit.cover,
                      ),
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(10, 300, 10, 0),
                  child: Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child:Column(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.only(left:20,right:20),
                            child:TextFormField(
                              validator: (input) => isEmail(input) ? null :'Invalid Email',
                              onChanged: (value) => _email = value,
                              decoration: InputDecoration(
                                  hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                  hintText: 'EMAIL',
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30),
                                    borderSide: BorderSide(
                                      color: Theme.of(context).primaryColor,
                                      width: 2,
                                    ),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 3,
                                      )
                                  ),
                                  prefixIcon: Padding(
                                    child:IconTheme(
                                      data:IconThemeData(color: Theme.of(context).primaryColor),
                                      child:Icon(Icons.email),
                                    ),
                                    padding: EdgeInsets.only(left: 30, right: 10),
                                  )
                              ),

                            )
                          ),
//                          CustomTextField(
//
//                            onSaved: (input){
//                              _email = input;
//                            },
//                            validator: (input) => isEmail(input) ? null :'Invalid Email',
//                            icon: Icon(Icons.email),
//                            hint: 'EMAIL',
//                          ),
                          Container(
                              padding: EdgeInsets.only(left:20,right:20,top: 20),
                              child:TextFormField(
                                obscureText: true,
                                validator: (input) => input.isEmpty ? '*Required' : null,
                                onChanged: (value) => _password = value,
                                decoration: InputDecoration(
                                    hintStyle: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
                                    hintText: 'PASSWORD',
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                      borderSide: BorderSide(
                                        color: Theme.of(context).primaryColor,
                                        width: 2,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                          width: 3,
                                        )
                                    ),
                                    prefixIcon: Padding(
                                      child:IconTheme(
                                        data:IconThemeData(color: Theme.of(context).primaryColor),
                                        child:Icon(Icons.vpn_key),
                                      ),
                                      padding: EdgeInsets.only(left: 30, right: 10),
                                    )
                                ),

                              )
                          ),
//                          Padding(
//                            padding: const EdgeInsets.only(top:20),
//                            child:CustomTextField(
//                              icon: Icon(Icons.lock),
//                              obscure: true,
//                              onSaved:(input) => _password = input,
//                              validator: (input) => input.isEmpty ? '*Required' : null,
//                              hint: 'PASSWORD',
//                            ),
//                          ),
                          Padding(
                            padding: const EdgeInsets.only(top:100),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(right: 20),
                                  child:FilledButton("LOGIN",Colors.white,Colors.black, Colors.black, Colors.white, signInWithEmail),
                                ),
                                FilledButton("REGISTER",Colors.white,Colors.black, Colors.black, Colors.white, signUpWithEmail)
                              ],
                            ),
                          ),



                        ],
                      ),

                  ),
                )
              ],
            )
        )
    );
  }
}


