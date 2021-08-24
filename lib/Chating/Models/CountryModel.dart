class CountryModel{
  String id,name;
  List<dynamic> cities;
  CountryModel({this.id, this.name, this.cities});

  CountryModel.fromjsion(Map map){
    this.id=map['id'];
    this.name=map['name'];
    this.cities=map['cities'];
  }
}