import 'package:apisample/model/datamodel.dart';
import 'package:apisample/service/api_service.dart';
import 'package:flutter/material.dart';

class DataProvider extends ChangeNotifier{
  
  TextEditingController nameController =TextEditingController();

  TextEditingController ageController =TextEditingController();
   List<DataModel> itemList=[];
  void loadNotes() async {
    try {
      List<DataModel> notes = await ApiService().getData();
      itemList = notes;
    } catch (error) {
      print('Error loading notes: $error');
    }
    notifyListeners();
  }
}