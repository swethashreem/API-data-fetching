import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class page4 extends StatefulWidget {
  const page4({super.key});

  @override
  State<page4> createState() => _page4State();
}

class _page4State extends State<page4> {
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
              future: fetchUserById(4), // Get user with ID 1
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