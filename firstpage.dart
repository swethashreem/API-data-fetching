import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'page1.dart';
import 'page2.dart';
import 'page3.dart';
import 'page4.dart';
import 'page5.dart';
import 'page6.dart';
import 'secondpage.dart';

class firstpage extends StatefulWidget {
  const firstpage({super.key});

  @override
  State<firstpage> createState() => _firstpageState();
}

class _firstpageState extends State<firstpage> {
  @override
 Future<Map<String, dynamic>> fetchUserById(int userId) async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users/$userId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> user = json.decode(response.body);
      return user;
    } else {
      throw Exception('Failed to load user');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('User Data'),
        ),
        body: Column(
          children: [
            FutureBuilder<Map<String, dynamic>>(
              future: fetchUserById(1), // Get user with ID 1
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  final Map<String, dynamic>? user = snapshot.data;
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user?['data']['avatar']),
                    ),
                    title: Text('${user?['data']['first_name']} ${user?['data']['last_name']}'),
                    subtitle: Text(user?['data']['email']),
                  );
                }
              },
            ),
            Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(),
                ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: (){
                     Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const page1()));
                  }, 
                  child:Text("1")),
                   ElevatedButton(
                  onPressed: (){
                     Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const page2()));
                  }, 
                  child:Text("2")),
                   ElevatedButton(
                  onPressed: (){
                     Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const page3()));
                  }, 
                  child:Text("3")),
                   ElevatedButton(
                  onPressed: (){
                     Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const page4()));
                  }, 
                  child:Text("4")),
                   ElevatedButton(
                  onPressed: (){
                     Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const page5()));
                  }, 
                  child:Text("5")),
                   ElevatedButton(
                  onPressed: (){
                     Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const page6()));
                  }, 
                  child:Text("6")),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(),
            ),
            ElevatedButton(
              onPressed: (){
                 Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => const secondpage()));
              }, 
              child: Text("NEXT PAGE"))
          ],
        ),
      ),
    );
  }
}
