import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_updates/models/slider_modal.dart';

class Sliders {
  List<sliderModal> sliders = [];
  Future<void> getSlider()async{
    String url = "https://newsapi.org/v2/top-headlines?sources=techcrunch&apiKey=4c908d3c8db540508541bc576144355f";
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);
    if(jsonData['status']=='ok'){
      jsonData["articles"].forEach((element){
        if(element["urlToImage"]!=null && element['description']!=null){
          sliderModal slidermodal = sliderModal(
            title: element["title"],
            description: element["description"],
            url: element["url"],
            urlToImage: element["urlToImage"],
            content: element["content"],
            author: element["author"],
          );
          sliders.add(slidermodal);
        }
      });
    }
  }
}