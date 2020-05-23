import 'package:brew_crew/models/brew.dart';
import 'package:brew_crew/screen/home/brew_list.dart';
import 'package:brew_crew/screen/home/settings_form.dart';
import 'package:brew_crew/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:brew_crew/services/database.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(){
      showModalBottomSheet(
        context: context, 
        builder: (context){
          return Container(
            padding: EdgeInsets.symmetric(vertical: 20.0,horizontal:60.0),
            child: SettingsForm(),
          );
        });
    }


    return StreamProvider<List<Brew>>.value(
        value: DatabaseService().brews,
        child: Scaffold(
        backgroundColor: Colors.brown[50],
        appBar: AppBar(
         title: Text("Brew Crew",
                 style: TextStyle(fontWeight: FontWeight.bold),),
          elevation: 0.0,
          backgroundColor: Colors.brown[400],
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person), 
              label: Text("logOut"),
              onPressed: () async {
                 await _auth.signOutof();
               } ,),
               FlatButton.icon(
                  icon: Icon(Icons.settings),
                   label: Text('settings'),
                   onPressed: () => _showSettingsPanel(),)
          ]
       ),
       body: Container(
         decoration: BoxDecoration(
           image: DecorationImage(
             image: AssetImage('assets/coffee_bg.png'),
             fit: BoxFit.cover,
             ),
         ),
         child: BrewList(),
         ),
      ),
    );
  }
}