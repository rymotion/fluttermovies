import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:io';
import 'package:http/http.dart' as http;

const String API_KEY = "--##get your own key with the instuctions##--";
Uri API_ENDPOINT = new Uri(scheme: "https://api.themoviedb.org/3/search/movie");


class Movie {
  // final int id;
  // final String titleOriginal;
  // final String marqueeURL;
  // final String title;
  // final String releaseDate;

  http.Client _client = new http.Client();
  // Movie({this.id, this.title, this.marqueeURL, this.titleOriginal, this.releaseDate});

  Future<List> movieResponse() async {
    http.Response _movieResponse = await _client.get("$API_ENDPOINT");
    print("${_movieResponse.statusCode} \n ${_movieResponse.body}");
    return ["hello"];
  }

  Future<List<Map<String,dynamic>>> findMyMovie(String queryObject) async {
    final _requestMovies = await http.get('https://api.themoviedb.org/3/search/movie?api_key=$API_KEY&language=en-US&query=$queryObject&page=1&include_adult=false');

    // http.Response _movieResponse = await _client.get("$API_ENDPOINT?api_key=$API_KEY&language=en-US&query=$queryObject&page=1&include_adult=false");
    print("query Response Body:${_requestMovies.statusCode}");
    List<Map<String,dynamic>> decodedResponse = json.decode(_requestMovies.body);
    return decodedResponse;
  }
}

// Movie createReference (Map <String, dynamic> json) {
//   return Movie(
//     id: json['id'] as int,
//     titleOriginal: json['original_title'] as String,
//     releaseDate: json['release_date']
//   );
// }