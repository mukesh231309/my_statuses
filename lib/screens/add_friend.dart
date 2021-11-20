import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mystatuses/screens/display_friends.dart';

class AddFriendPage extends StatefulWidget {
  @override
  _AddFriendPageState createState() => _AddFriendPageState();
}

class _AddFriendPageState extends State<AddFriendPage> {
  bool isLoading = false;

  var nameController = TextEditingController();
  var phoneController = TextEditingController();
  var typeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
                    TextField(
                      controller: nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Name",
                      ),
                    ),
                    TextField(
                      controller: phoneController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Phone",
                      ),
                    ),
                    TextField(
                      controller: typeController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Type",
                      ),
                    ),
              RaisedButton(
                child: Text("Add Friend"),
                onPressed: (){
                  setState(() {
                    isLoading = true;
                  });
                  var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    FirebaseDatabase.instance.reference().child("friends/std" + timestamp.toString()).set(
                      {
                        "name" : nameController.text,
                        "phone" : phoneController.text,
                        "type" : typeController.text,
                        "image" : 'https://img.icons8.com/officel/2x/user.png',
                      }
                    ).then((value) {
                      print("Successfully added the friend");
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.push(context, MaterialPageRoute(builder: (context) => DisplayFriends()));
                    }).catchError((error){
                            print("Failed to add" +error.toString());
                    });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
