import 'package:apisample/controller/data_provider.dart';
import 'package:apisample/model/datamodel.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ApiService{
  final endpoint='https://65618241dcd355c08323e66b.mockapi.io/MockData';
 
  Dio dio = Dio();
 Future<List<DataModel>> getData()async{
    try{
      Response res= await dio.get(endpoint);
      if(res.statusCode==200){
        var jsonList=res.data as List;
        List<DataModel> itemList = jsonList.map((json){
          return DataModel.fromJson(json);
        }).toList();
        return itemList;
      }else{
        throw Exception('Data is not get');
      }
      
    }catch(e){
      throw Exception('this is the issue$e');
    }
  }
  createData(DataModel value)async{
    try{
      await dio.post(endpoint,data:value.toJson());
    }catch(e){
      throw Exception(e);
    }
  }
  deleteData({required id})async{
    try{
    var deleUrl = 'https://65618241dcd355c08323e66b.mockapi.io/MockData/$id';
    await dio.delete(deleUrl);
    }catch(e){
    throw Exception(e);
    }
  }
  editData({ required DataModel data, required id})async{
    try{
    var editUrl = 'https://65618241dcd355c08323e66b.mockapi.io/MockData/$id';
    await dio.put(editUrl,data:data.toJson() );
    }catch(e){
    throw Exception(e);
    }
  }
}