import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:http/http.dart" as http;
import "dart:convert";
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _nameController = TextEditingController();
  var result;

  predictGender(String name) async {
    var url = "https://api.genderize.io/?name=$name";
    var res = await http.get(Uri.parse(url));
    var body = jsonDecode(res.body);
    result="Gender:${body['gender']}, probability:${body['probability']}";
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Gender Predictor")),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                "Enter a name to predict its gender",
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextField(
                    //obscureText: true,
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Name",
                    )),
              ),
              ElevatedButton(
                onPressed: () => predictGender(_nameController.text),
                child: Text("Predict"),
              ),
              if (result != null) Text(result)
            ],
          ),
        ));
  }
}
