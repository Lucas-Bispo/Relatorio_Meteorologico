import 'dart:html';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  
}

Future getWeather(String city){
  String url = 'https://api.hgbrasil.com/weather/?format=json-cors&locale=pt&city_name=$city&key=0170eb3e';
  return http.get(url);
}

void loadData(List cities){
  var empty = querySelector('#empty');

  if(empty != null){
    empty.remove();

    cities.forEach((city){
      insertData(getWeather(city));

    });
  }
}
