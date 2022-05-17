import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Users',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: User_details(),
    );
  }
}

late String stringResponse;
late Map mapResponse;
late Map dataResponse;
// late List listResponse;

class User_details extends StatefulWidget {
  @override
  State<User_details> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<User_details> {
  bool isLoading = false;
  final url = "https://reqres.in/api/users/2";

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        dataResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState(){
    apicall();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Profile Page"),
        ),
        body:Padding(
          padding: const EdgeInsets.all(20.0),
          child: Center(
            child : isLoading?CircularProgressIndicator():Column(
                  children: [
                    CircleAvatar(
                        radius: 50,
                        child: ClipOval(
                          child: Image.network(dataResponse['avatar'].toString()),
                        )),
                    SizedBox(height: 5),
                    Text('Id - ${dataResponse['id'].toString()}'),
                    SizedBox(height: 5),
                    Text('First name - ${dataResponse['first_name'].toString()}'),
                    SizedBox(height: 5),
                    Text('Last name - ${dataResponse['last_name'].toString()}'),
                    SizedBox(height: 5),
                    Text('E-mail - ${dataResponse['email'].toString()}'),
                  ],
                ),
          ),
        )
    );
  }
}
