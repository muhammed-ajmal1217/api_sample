import 'package:apisample/model/datamodel.dart';
import 'package:apisample/service/api_service.dart';
import 'package:flutter/material.dart';

class EditPage extends StatefulWidget {
  DataModel data;
  String id;
   EditPage({super.key,required this.data,required this.id});

  @override
  State<EditPage> createState() => _EditPageState();
}

class _EditPageState extends State<EditPage> {
  TextEditingController nameController =TextEditingController();
  TextEditingController ageController =TextEditingController();
  ApiService api = ApiService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nameController= TextEditingController(text: widget.data.name);
    ageController= TextEditingController(text: widget.data.age);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
              children: [
                SizedBox(height: 80,),
                TextFormField(
              controller: nameController,
              decoration: InputDecoration(
              hintText: 'Name'
            ),),
            TextFormField(
              controller: ageController,
              decoration: InputDecoration(
              hintText: 'Age'
            ),),
            ElevatedButton(onPressed: (){
              setState(() {
              final data=DataModel(name: nameController.text,age: ageController.text);
                api.editData(data: data, id: widget.id);
              });
              Navigator.pop(context);
            }, child: Text('Update'))
              ],
            ),
    );
  }
}