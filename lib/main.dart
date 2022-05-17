import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user/user_details.dart';

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
      home: MyHomePage(),
    );
  }
}

late String stringResponse;
late Map mapResponse;
late Map dataResponse;
late List listResponse;

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final url = "https://reqres.in/api/users?page=1";

  Future apicall() async {
    http.Response response;
    response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        mapResponse = json.decode(response.body);
        listResponse = mapResponse['data'];
      });
    }
  }

  @override
  void initState() {
    apicall();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("Users Details"),
        ),
        body: SafeArea(
          child: ListView.builder(
              itemCount: listResponse.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                            radius: 28,
                            child: ClipOval(
                              child: Image.network(
                                  (listResponse[index]['avatar'].toString())),
                            )),
                        title: Text(
                            listResponse[index]['first_name'].toString()),
                        subtitle:
                            Text(listResponse[index]['email'].toString()),
                        trailing: const Icon(Icons.arrow_forward_sharp),
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => User_details()));
                        },
                      ),
                    ],
                  ),
                );
              }),
        ));
  }
}
