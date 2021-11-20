import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:mystatuses/screens/add_friend.dart';
import 'package:mystatuses/screens/friend_details.dart';


class DisplayFriends extends StatefulWidget {
  @override
  _DisplayFriendsState createState() => _DisplayFriendsState();
}

class _DisplayFriendsState extends State<DisplayFriends> {

  var friendList= [];
  _DisplayFriendsState(){
    _refreshFriendList();
    FirebaseDatabase.instance.reference().child("friends").onChildChanged.listen((event) {
      _refreshFriendList();
    });
    FirebaseDatabase.instance.reference().child("friends").onChildRemoved.listen((event) {
      _refreshFriendList();
    });
    FirebaseDatabase.instance.reference().child("friends").onChildAdded.listen((event) {
      _refreshFriendList();
    });
  }

    _refreshFriendList(){
      FirebaseDatabase.instance.reference().child("friends").once()
          .then((datasnapshot) {
        print("Success");
        var frriendTmpList = [];
        datasnapshot.value.forEach((k, v){
          frriendTmpList.add(v);
          friendList = frriendTmpList;
          setState(() {

          });
        });
      }).catchError((error){
        print("Failed");
      });
    }

  //List<friend> friends;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: friendList.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FriendDetails(friendList[index])));
                },
                title: Container(
                  margin: EdgeInsets.only(top: 5, bottom: 5, left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: 20.0),
                        child: CircleAvatar(
                          backgroundImage: NetworkImage('${friendList[index]['image']}'),
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text('${friendList[index]['name']}', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('${friendList[index]['phone']}'),
                        ],
                      ),

                      Spacer(),
                      Text('${friendList[index]['type']}'),
                    ],
                  ),
                ),
              );
            }),

      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddFriendPage()),
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

