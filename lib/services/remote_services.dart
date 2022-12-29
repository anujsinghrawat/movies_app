import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_app/models/nowplaying.dart';

String api_key = 'd963d9f04d274bee7d9688b078773777';

class RemoteService {
  static Future<List<Movie>?> nowPlaying() async {
    var uri =
        Uri.parse('https://api.themoviedb.org/3/movie/now_playing?api_key=$api_key'
            '&language=en-US&page=1');
    
    final response = await http.get(uri);
    final body = jsonDecode(response.body);
    // print(body);

    List<Movie> abc = [];
    for (int i = 0; i < body['results'].length; i++) {
      abc.add(Movie(
        title: body['results'][i]['title'],
        poster_path: body['results'][i]['poster_path'],
        stars: body['results'][i]['vote_average'],
        name: body['results'][i]['name'],
      ));
    }
      return abc;
  }
  static Future<List<Movie>?> trending() async {
    var uri =
        Uri.parse('https://api.themoviedb.org/3/movie/popular?api_key=$api_key'
            '&language=en-US&page=1');
    var base_url = 'http://image.tmdb.org/t/p/w500';
    final response = await http.get(uri);
    final body = jsonDecode(response.body);
    // print(body);

    List<Movie> abc = [];
    for (int i = 0; i < body['results'].length; i++) {
      abc.add(Movie(
        title: body['results'][i]['title'],
        poster_path: body['results'][i]['poster_path'],
        stars: body['results'][i]['vote_average'],
        name: body['results'][i]['name'],
      ));
    }
      return abc;
  }


  static Future<List<Movie>?> topRated() async {
    var uri =
        Uri.parse('https://api.themoviedb.org/3/movie/top_rated?api_key=$api_key'
            '&language=en-US&page=1');
    var base_url = 'http://image.tmdb.org/t/p/w500';
    final response = await http.get(uri);
    final body = jsonDecode(response.body);
    // print(body);

    List<Movie> abc = [];
    for (int i = 0; i < body['results'].length; i++) {
      abc.add(Movie(
        title: body['results'][i]['title'],
        poster_path: body['results'][i]['poster_path'],
        stars: body['results'][i]['vote_average'],
        name: body['results'][i]['name'],
      ));
    }
      return abc;
  }
}
