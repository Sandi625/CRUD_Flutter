import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

final http.Client client = http.Client();


class DateTimePickerExample extends StatefulWidget {
  @override
  _DateTimePickerExampleState createState() => _DateTimePickerExampleState();
}

class _DateTimePickerExampleState extends State<DateTimePickerExample> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;
  late TextEditingController descriptionController;
  late TextEditingController selectedDate;


  get http => null;
  
  
  
  

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _selectedTime = TimeOfDay.now();
    descriptionController = TextEditingController();
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final initialDate = _selectedDate;
    final initialTime = _selectedTime;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: initialTime,
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
          _selectedTime = pickedTime;
        });
      }
    }
  }
  

  // void _saveData() async {
  //   final description = _descriptionController.text;
  //   final url = 'http://192.168.1.6/flutterapi/crudflutter/save_data';
  //   final response = await http.post(Uri.parse(url), body: {
  //       'selectedDate': selectedDate.toString(),
  //       'description': description,
  //   });
  
//     if (response.statusCode == 200) {
//         print('Data saved successfully');
//     } else {
//         print('Failed to save data');
//     }
// }


// final url = Uri.parse('http://example.com/save_data.php');


// void postData() async {
//  final response = await http.post(url, body: {'selectedDate': selectedDate, 'description': description});
//     Uri.parse('http://192.168.1.4/flutterapi/crudflutter/save_data');
  
//   print(response.statusCode);
//   print(response.body);
// }
// Future _simpan() async {
//     var description;
//     final respone = await http.post(
//         Uri.parse(''),
//         body: {
//           "selectedDate": _selectedDate.day,
//           "description": description.toString(),
          
//         });
//     if (respone.statusCode == 200) {
//       return true;
//     }
//     return false;
//   }
  
  late String pilihTanggal, labelText;
  DateTime tgl = new DateTime.now();
  final TextStyle valueStyle = TextStyle(fontSize: 16.0);
  Future _simpan() async {
    final response = await http.post(Uri.parse('http://192.168.1.4/flutterapi/crudflutter/save_data.php'));
    final DateTime? picked = await showDatePicker(
      
        context: context,
        initialDate: tgl,
        firstDate: DateTime(1992),
        lastDate: DateTime(2099));

    if (picked != null && picked != tgl) {
      setState(() {
        tgl = picked;
        pilihTanggal = DateFormat.yMd().format(tgl);
      });
    } else {}
  }
//   Future _simpan() async {
//   var description;
//   final response = await http.post(Uri.parse('http://192.168.1.4/flutterapi/crudflutter/save_data.php'),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       body: jsonEncode(<String, String>{
//          "selectedDate": selectedDate.text,
//           "description": description.toString(),
//       }));
//   return response;
// }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Date and Time Picker Example'),
        ),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Text(
                'Selected Date and Time:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(_selectedDate.toString()),
              SizedBox(
                height: 20.0,
              ),
              Text(
                'Selected Date and Time:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black87,
                ),
              ),
              ElevatedButton(
                onPressed: () => _selectDateTime(context),
                child: Text(
                  'Select date and time',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blue, // warna latar belakang tombol
                  padding:
                      EdgeInsets.symmetric(vertical: 12.0, horizontal: 24.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0),
                child: TextField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.blue,
                        width: 2.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                  maxLines: 5,
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.black87,
                  ),
                ),
              ), // warna teks tombol
              ElevatedButton(
                  onPressed: _simpan,
                  child: Text(
                    'Save',
                    style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // warna latar belakang tombol
                      padding: EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 24.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      )))
            ],
          ),
        ));
  }
}

class DateFormat {
  static yMd() {}
}
