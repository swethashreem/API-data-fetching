import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class secondpage extends StatefulWidget {
  const secondpage({super.key});

  @override
  State<secondpage> createState() => _secondpageState();
}

class _secondpageState extends State<secondpage> {
   Future<List<dynamic>> fetchData() async {
    final response = await http.get(Uri.parse('https://reqres.in/api/users'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final List<dynamic> users = data['data'];
      return users;
    } else {
      throw Exception('Failed to load data');
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
        body: FutureBuilder<List<dynamic>>(
          future: fetchData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else {
              final List? users = snapshot.data;
              return ListView.builder(
                itemCount: users!.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user['avatar']),
                    ),
                    title: Text('${user['first_name']} ${user['last_name']}'),
                    subtitle: Text(user['email']),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}

