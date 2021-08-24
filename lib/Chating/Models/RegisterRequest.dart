class RegisterRequest{
  String fName,lName,city,country,Email,password,id,imgurl;
  RegisterRequest({this.fName,this.lName,this.city,this.country,this.Email,this.password,this.id,this.imgurl});
toMap(){
  return {
    'id':this.id,
    'fName':this.fName,
    'lName':this.lName,
    'country':this.country,
    'city':this.city,
    'Email':this.Email,
    'imgurl':this.imgurl
  };
}

}