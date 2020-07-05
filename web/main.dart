import 'dart:html';
import 'dart:convert';
import 'package:dialog/dialog.dart';
import 'package:http/http.dart' as http;

void main() {
  
  /*List cities = List();
  cities.add('Nova Friburgo');
  cities.add('Rio de Janeiro');
  cities.add('Itaperuma');
  cities.add('São Paulo');
  cities.add('Campinas');
  cities.add('Londres');
  
  loadData(cities);
*/
  querySelector('#searchCity').onClick.listen((a) async{
    var myPrompt = await prompt('Qual cidade você quer buscar ?');

    if(myPrompt.toString().length > 0)
      loadData([myPrompt.toString()]);
    else
      alert('Nunhuma cidade informada!');
  });

}

Future getWeather(String city){
  String url = 'https://api.hgbrasil.com/weather/?format=json-cors&locale=pt&city_name=$city&key=0170eb3e ';
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
void insertData(Future data) async{
  
  var insertData = await data;
  var body = json.decode(insertData.body);


  if(body['reslts']['forecast'].length > 0){
    String html = '<div class="row">';
    html += formateHTML(body['results']['city_name']);
    html += formateHTML(body['results']['temp']);
    html += formateHTML(body['results']['description']);
    html += formateHTML(body['results']['wind_speedy']);
    html += formateHTML(body['results']['sunrise']);
    html += formateHTML(body['results']['sunset']);

    html += '</div>';

    querySelector('.table').innerHtml += html;

  }

}
String formateHTML(var data){
  return '<div class="cell">$data</div>';

}
