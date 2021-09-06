
import 'package:url_launcher/url_launcher.dart';
import 'package:share/share.dart';
class Url_lancher_helper{
  Url_lancher_helper._();
  static Url_lancher_helper url = Url_lancher_helper._();

  lanchurl(String url)async{
    launch(url,universalLinksOnly: true);
  }
  openWebpage(String url){
  try{
    lanchurl(url);
  }on Exception catch(e){
    print(e);
  }
  }
  shareContent(){
    Share.share('helllooo');
  }
  senEmail(){
    try{
      lanchurl('mailto:sss@example.org?subject=News&body=New%20plugin');
    }catch(e){
      print(e);
    }
  }
  sendSms(){
    try{
      lanchurl('sms:548515');
    }catch(e){
      print(e);
    }
  }
  openWatsapp(){
    try{
      lanchurl('https://wa.me/0597735620');
    }catch(e){
      print(e);
    }
  }
  makeCall(){
    try{
      lanchurl('tel:+1 85155 102');
    }catch(e){
      print(e);
    }
  }
openInsta(){
  try{
    lanchurl('https://www.instagram.com/omar');
  }catch(e){
    print(e);
  }
}
}