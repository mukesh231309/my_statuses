import 'package:flutter/material.dart';

class FriendDetails extends StatefulWidget {
  var contactDetails;
  FriendDetails(this.contactDetails);
  @override
  _FriendDetailsState createState() => _FriendDetailsState();
}

class _FriendDetailsState extends State<FriendDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Friend Details"),
        backgroundColor: Colors.pink,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(10.0),
                width: 100.0,
                height: 100.0,
                child: CircleAvatar(
                  backgroundImage: NetworkImage('${widget.contactDetails['image']}'),
                ),
              ),
              Text("${widget.contactDetails['name']}"),
              Text("${widget.contactDetails['phone']}"),
              Text("${widget.contactDetails['type']}"),
              //Text("${widget.contactDetails['image']}"),

            ],
          ),
        ),
      ),
    );
  }
}
