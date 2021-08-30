class ChatFire {
  String message,userId,timeDate;

  ChatFire(
      {this.message,this.userId,this.timeDate
      });

  toMap() {
    return {
      'message':this.message,
      'userId':this.userId,
      'id':this.message,
    };
  }

  ChatFire.fromMap(Map map) {
    this.userId = map['userId'];
    this.message = map['message'];
    this.message = map['message'];

  }
}
