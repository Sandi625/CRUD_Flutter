import 'package:flutter/material.dart';
import 'package:flutter_crud/datepicker/DatePickerExample.dart';
import 'package:flutter_crud/homepage.dart';
import 'package:flutter_crud/datepicker/DatePickerExample.dart';
import 'homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
      
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Manage Waktu'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(title),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets. only(left: 20.0, right: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.account_circle),
                  labelText: 'Username',
                ),
              ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
              ),
                //password
            TextField(
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: 'Password',
              ),
              obscureText: true,
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 20.0),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 40.0 ),
                    child: ElevatedButton(
                      child:Text('Login'),
                      onPressed: () {
                        Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      },
                      ),
                  ),
                ),
              ],
            ),
            ],
          ),
        ),
      ),
    );
  }
}