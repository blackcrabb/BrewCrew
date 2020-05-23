import 'package:brew_crew/services/auth.dart';
import 'package:brew_crew/shared/constants.dart';
import 'package:brew_crew/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {

   final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  //text field state
  String email= '';
  String password='';
  String error='';
  
  @override
  Widget build(BuildContext context) {
    return loading ? Loading() :Scaffold(
      backgroundColor: Colors.brown[100],
      appBar: AppBar(
        backgroundColor: Colors.brown[400],
        elevation: 10,
        title: Text("Sign in to Brew Crew"),
        actions: <Widget>[
          FlatButton.icon(
            onPressed: () {widget.toggleView();}, 
            icon: Icon(Icons.person),
             label: Text('Register'),
             )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0,horizontal: 50.0),
      /*  child: RaisedButton(
          child: Text("SIGN anon"),
          onPressed: () async{
            dynamic result = await _auth.signInAnon();
            if(result == null){
              print('error signing in');
            }else{
              print('signed in');
              print(result.uid);
            }
          }),*/
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Email'),
                  validator: (val) => val.isEmpty ? 'Enter an email' : null,
                  onChanged: (val){
                    setState(() => email = val);
                  },
                ),
                SizedBox(height: 20.0,),
                TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'Password'),
                  obscureText: true,
                  validator: (val) => val.length < 6 ? 'Enter a passwor 6+ chars long' : null,
                  onChanged: (val){
                    setState(() => password = val);
                  },
                ),
                SizedBox(height: 20.0,),
                RaisedButton(
                  color: Colors.brown[400],
                  child: Text('Sign in',style: TextStyle(color: Colors.white),),
                  onPressed: () async {
                    if(_formKey.currentState.validate()){
                      setState(()=>loading=true);
                     dynamic result = await _auth.signInWithEmailAndPassword(email, password);
                     if(result == null){
                       setState(() {
                         error ='COULD NOT SIGN IN WITH THOSE CREDENTIALS';
                         loading=false;
                       } );
                     }
                    }
                  },
                  ),
                  SizedBox(height: 12.0,),
                  Text(
                    error,
                    style: TextStyle(color: Colors.brown,fontSize: 14.0),
                  )
              ],
            )
            ),
      ),
    );
  }
}