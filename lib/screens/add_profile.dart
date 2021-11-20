import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';


class AddProfile extends StatefulWidget {
  @override
  _AddProfileState createState() => _AddProfileState();
}

class _AddProfileState extends State<AddProfile> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;

    var emailController = TextEditingController();
    var passwordController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    //var typeController = TextEditingController();

    int _groupValue;
    String selectedPhoneType;

    void radioValueChanged(int value){
      print(value.toString());

      setState(() {
        _groupValue = value;
        if(_groupValue == 0){
          selectedPhoneType = "Cell";
        }
        if(_groupValue == 1){
          selectedPhoneType = "Work";
        }
        if(_groupValue == 2){
          selectedPhoneType = "Home";
        }
        print(selectedPhoneType);
      });
    }

      return Scaffold(
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Email",
                  ),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: "Password",
                  ),
                ),
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 0,
                      groupValue: _groupValue,
                      onChanged: radioValueChanged,
                    ),
                    Text("Cell"),

                    Radio(
                      value: 1,
                      groupValue: _groupValue,
                      onChanged: radioValueChanged,
                    ),
                    Text("Work"),

                    Radio(
                      value: 2,
                      groupValue: _groupValue,
                      onChanged: radioValueChanged,
                    ),
                    Text("Home"),
                  ],
                ),
                RaisedButton(
                  child: Text("Add Profile"),
                  onPressed: () {
                    setState(() {
                      isLoading = true;
                    });
                    //var timestamp = new DateTime.now().millisecondsSinceEpoch;
                    FirebaseAuth.instance.createUserWithEmailAndPassword(email: emailController.text, password: passwordController.text)
                    .then((authResult) {
                      var userProfile = {
                            "uid" : authResult.user.uid,
                            "name" : nameController.text,
                            "phone" : phoneController.text,
                            "email" : emailController.text,
                            "type" : selectedPhoneType,
                      };
                      
                      FirebaseDatabase.instance.reference().child("friends/" + authResult.user.uid)
                        .set(userProfile)
                        .then((value) {
                          
                      }).catchError((error){
                            print(error.toString());
                      });
                      //Navigator.pop(context);
                    }).catchError((error){
                          print(error.toString());
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