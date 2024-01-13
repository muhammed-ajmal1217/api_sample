class DataModel{
  String? id;
  String? name;
  String? age;
  DataModel({
    this.name,
    this.age,
    this.id,
  });
  factory DataModel.fromJson(Map<String,dynamic> json){
    return DataModel(
      name: json['Name'],
      age: json['Age'],
      id:json['id']
    );
  }
  Map<String,dynamic> toJson(){
    return {
      'Name':name,
      'Age':age,
      'id':id,
    };
  }
}