import 'package:flutter/material.dart';
import 'package:flutter_crud/homepage.dart';
import 'package:http/http.dart' as http;

import 'homepage.dart';

class EditDataPage extends StatefulWidget {
  final Map ListData;
  EditDataPage({Key? key, required this.ListData}) : super(key: key);

  @override
  State<EditDataPage> createState() => _EditDataPageState();
}

class _EditDataPageState extends State<EditDataPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController id = TextEditingController();
  TextEditingController nisn = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController paket = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  Future _update() async {
    final respone = await http.post(
        Uri.parse('http://192.168.1.8/flutterapi/crudflutter/edit.php'),
        body: {
          "id": id.text,
          "nisn": nisn.text,
          "nama": nama.text,
          "alamat": alamat.text,
          "paket": paket.text,
          "keterangan": keterangan.text,
        });
    if (respone.statusCode == 200) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    id.text = widget.ListData['id'];
    nisn.text = widget.ListData['nisn'];
    nama.text = widget.ListData['nama'];
    alamat.text = widget.ListData['alamat'];
    paket.text = widget.ListData['paket'];
    keterangan.text = widget.ListData['keterangan'];
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit data"),
      ),
      body: Form(
          key: formkey,
          child: Container(
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  TextFormField(
                      controller: nisn,
                      decoration: InputDecoration(
                        hintText: "ID Pelanggan",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Id Pelanggan Tidak boleh kosong";
                        }
                      }),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: nama,
                    decoration: InputDecoration(
                      hintText: "Nama",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Nama Tidak boleh kosong";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: alamat,
                    decoration: InputDecoration(
                      hintText: "Alamat",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Alamat Tidak boleh kosong";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: paket,
                    decoration: InputDecoration(
                      hintText: "paket",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "paket Tidak boleh kosong";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    controller: keterangan,
                    decoration: InputDecoration(
                      hintText: "Keterangan",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return " Keterangan Tidak boleh kosong";
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if (formkey.currentState!.validate()) {
                          _update().then((value) {
                            if (value) {
                              final snackBar = SnackBar(
                                content: const Text('Data berhasil di update'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                content: const Text('Data gagal di update'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            }
                          });
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: ((context) => HomePage())),
                              (route) => false);
                        }
                      },
                      child: Text("Update"))
                ],
              ))),
    );
  }
}
