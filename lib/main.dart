import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'Student.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'REST API Tutorial',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:MyHomePage(),
    );
  }
}

class MyHomePage  extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       title: Text("REST API SAMPELE")
       ,),
     body: FutureBuilder<List<Student>>(
        future:fetchStudents(),
       builder:(context,snapshot){
          if(!snapshot.hasData){
            return Center(
                child:CircularProgressIndicator());
          }
          return ListView(
        children: snapshot.data!.map((items)=>
        ListTile(
        title: Text(items.name),
          onTap: (){
          Fluttertoast.showToast(
            msg: items.name,
            toastLength: Toast.LENGTH_LONG,
            timeInSecForIosWeb: 1,
            textColor: Colors.white,
            backgroundColor: Colors.green,
            gravity: ToastGravity.CENTER
          );
          },
        )
        ).toList(),
          );


       },
     ),

   );
  }
  Future<List<Student>> fetchStudents() async {
      var url =
      Uri.https('your-url.com', '/student.json', {'q': '{http}'});
      var response = await http.get(url);
      if (response.statusCode == 200) {

       final data = json.decode(response.body).cast<Map<String, dynamic>>();

        List<Student> students = data.map<Student>((map) {
          return Student.fromJson(map);
        }).toList();

        return students;
      }
      else {
        throw Exception('Something went wrong');
      }

  }

}
