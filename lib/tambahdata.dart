import 'package:flutter/material.dart';
import 'package:flutter_crud/homepage.dart';
import 'package:flutter_crud/homepage.dart';
import 'package:http/http.dart' as http;

import 'homepage.dart';

class TambahDataPage extends StatefulWidget {
  TambahDataPage({Key? key}) : super(key: key);

  @override
  State<TambahDataPage> createState() => _TambahDataPageState();
}

class _TambahDataPageState extends State<TambahDataPage> {
  final formkey = GlobalKey<FormState>();
  TextEditingController nisn = TextEditingController();
  TextEditingController nama = TextEditingController();
  TextEditingController alamat = TextEditingController();
  TextEditingController paket = TextEditingController();
  TextEditingController keterangan = TextEditingController();
  Future _simpan() async {
    final respone = await http.post(
        Uri.parse('http://192.168.1.8/flutterapi/crudflutter/create.php'),
        body: {
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
    return Scaffold(
      appBar: AppBar(
        title: Text("Tambah data"),
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
                          _simpan().then((value) {
                            if (value) {
                              final snackBar = SnackBar(
                                content: const Text('Data berhasil di simpan'),
                              );
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                            } else {
                              final snackBar = SnackBar(
                                content: const Text('Data gagal di simpan'),
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
                      child: Text("Simpan"))
                ],
              ))),
    );
  }
}
