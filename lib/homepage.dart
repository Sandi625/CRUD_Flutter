import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_crud/editdata.dart';
import 'package:flutter_crud/main.dart';
import 'package:flutter_crud/tambahdata.dart';
import 'package:http/http.dart' as http;

import 'editdata.dart';
import 'tambahdata.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override



  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _listdata = [];
  bool _isloading = true;

  Future _getdata() async {
    try {
      final respone = await http.get(
          Uri.parse('http://192.168.1.8/flutterapi/crudflutter/read.php'));
      if (respone.statusCode == 200) {
        //print(respone.body);
        final data = jsonDecode(respone.body);
        setState(() {
          _listdata = data;
          _isloading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  Future _hapus(String id) async {
    try {
      final respone = await http.post(
          Uri.parse('http://192.168.1.8/flutterapi/crudflutter/hapus.php'),
          body: {
            "nisn": id,
          });
      if (respone.statusCode == 200) {
        return true;
      }
      return false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getdata();
    //  print(_listdata);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("CRUD Flutter"),
        
      ),
      
      body: _isloading
          ? Center(
            child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: _listdata.length,
              itemBuilder: ((context, index) {
                return Card(
                    child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: ((context) => EditDataPage(
                                  ListData: {
                                    "id": _listdata[index]['id'],
                                    "nisn": _listdata[index]['nisn'],
                                    "nama": _listdata[index]['nama'],
                                    "alamat": _listdata[index]['alamat'],
                                    "paket": _listdata[index]['paket'],
                                    "keterangan": _listdata[index]
                                        ['keterangan'],
                                  },
                                ))));
                                Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
        title: Text('Flutter Demo'),),
        body: Center(child: ElevatedButton(child: Text("Back"),
        onPressed:() {Navigator.pushReplacement(context, 
                        MaterialPageRoute(builder: (context) {
                          return HomePage();
                        }));
                      },
                      ),
                  ),
                    
      );
    }
                  },
                  child: ListTile(
                      title: Text(_listdata[index]['nama']),
                      subtitle: Text(_listdata[index]['alamat']),
                      trailing: IconButton(
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: ((context) {
                                  return AlertDialog(
                                    content: Text(
                                        "Yakin anda ingin menghapus data?"),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () {
                                            _hapus(_listdata[index]['nisn'])
                                                .then((value) {
                                              if (value) {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Data berhasil di hapus'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              } else {
                                                final snackBar = SnackBar(
                                                  content: const Text(
                                                      'Data gagal di hapus'),
                                                );
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(snackBar);
                                              }
                                            });
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                MaterialPageRoute(
                                                    builder: ((context) =>
                                                        HomePage())),
                                                (route) => false);
                                          },
                                          child: Text("hapus")),
                                      ElevatedButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("Batal"))
                                    ],
                                  );
                                }));
                          },
                          icon: Icon(Icons.delete))),
                ));
              }),
            ),
            
            
      floatingActionButton: FloatingActionButton(
          child: Text("+", style: TextStyle(fontSize: 30)),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: ((context) => TambahDataPage())));
          }),
          
    );
  }
}

