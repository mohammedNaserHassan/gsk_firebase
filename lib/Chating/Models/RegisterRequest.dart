class RegisterRequest {
  String fName, lName, city, country, Email, password, id, imgurl;

  RegisterRequest(
      {this.fName,
      this.lName,
      this.city,
      this.country,
      this.Email,
      this.password,
      this.id,
      this.imgurl
      });

  toMap() { 
    return {
      'id': this.id,
      'fName': this.fName,
      'lName': this.lName,
      'country': this.country,
      'city': this.city,
      'Email': this.Email,
      'imgurl': this.imgurl
    };
  }

  RegisterRequest.fromMap(Map map) {
    this.id = map['id'];
    this.Email = map['Email'];
    this.city = map['city'];
    this.country = map['country'];
    this.fName = map['fName'];
    this.lName = map['lName'];
    this.imgurl = map['imgurl'];
  }
}
