import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class page3 extends StatefulWidget {
  const page3({super.key});

  @override
  State<page3> createState() => _page3State();
}

class _page3State extends State<page3> {
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
        body:FutureBuilder<Map<String, dynamic>>(
              future: fetchUserById(3), // Get user with ID 1
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
                    title: Text('${user?['data']['id']} ${user?['data']['first_name']} ${user?['data']['last_name']}'),
                    subtitle: Text(user?['data']['email']),
                  );
                }
              },
            ),
      )
    );
  }
}