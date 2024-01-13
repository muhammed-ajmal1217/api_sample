
import 'package:apisample/controller/data_provider.dart';
import 'package:apisample/model/datamodel.dart';
import 'package:apisample/service/api_service.dart';
import 'package:apisample/views/editpage.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
   HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ApiService api=ApiService();
 @override
  void initState() {
    super.initState();
    Provider.of<DataProvider>(context, listen: false).loadNotes();
  }

  @override
  Widget build(BuildContext context) {
    final pro = Provider.of<DataProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 60,),
          Text('Api Sample',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600),),
          SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.only(left: 15,right: 15),
            child: Column(
              children: [
                TextFormField(
              controller: pro.nameController,
              decoration: InputDecoration(
              hintText: 'Name'
            ),),
            TextFormField(
              controller: pro.ageController,
              decoration: InputDecoration(
              hintText: 'Age'
            ),),
            ElevatedButton(onPressed: (){
              final data=DataModel(name: pro.nameController.text,age: pro.ageController.text);
              setState(() {
                api.createData(data);
              });
            }, child: Text('Add'))
              ],
            ),
          ),

          Expanded(
            child: FutureBuilder(
              future: api.getData(),
              builder: (context, snapshot) {
                final data=snapshot.data;
                if(snapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else if (snapshot.hasError){
                  return Text('Snapshot has error');
                }
              return ListView.builder(
                itemBuilder: (context, index) {
                  DataModel datas= pro.itemList[index];
                  final id = data[index].id;
                  return ListTile(
                    title: Text(datas.name??'the name is not available'),
                    subtitle: Text(datas.age??'the age is not available'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          onTap: () {
                            setState(() {
                              Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditPage(data: datas,id: datas.id!),));
                            });
                          },
                          child: Icon(Icons.edit)),
                        SizedBox(width: 10,),
                        InkWell(
                          onTap: () {
                            setState(() {
                              api.deleteData(id: id);
                            });
                          },
                          child: Icon(Icons.delete)),
                      ],
                    ),
                  );
                },
                itemCount: data!.length,
                );
            },),
          ),
        ],
      ),
    );
  }
}