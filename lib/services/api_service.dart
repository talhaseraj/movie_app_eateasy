import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app_eateasy/models/cast_details_model.dart';
import 'package:movie_app_eateasy/models/movie_details_model.dart';
import 'package:movie_app_eateasy/views/movie_detail_view.dart';
import '../models/movies_list_response.dart';

class ApiService {
  final String apiKey =
      'abb2a6fb6af5922c9159176be5f889fe'; // Replace with your TMDb API key
  final String baseUrl = 'https://api.themoviedb.org/3';

  Future<List<Movie>> fetchMovies(int page) async {
    final response = await http
        .get(Uri.parse('$baseUrl/movie/popular?api_key=$apiKey&page=$page'));
    print("response: " + response.body);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['results'] as List)
          .map((movieJson) => Movie.fromJson(movieJson))
          .toList();
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<MovieDetails> fetchMovieDetails(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$id?api_key=$apiKey'));
    print("response: " + response.body);
    if (response.statusCode == 200) {
      return movieDetailsFromJson(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }

  Future<CastDetails> fetchMovieCast(int id) async {
    final response =
        await http.get(Uri.parse('$baseUrl/movie/$id/credits?api_key=$apiKey'));
    print("response: " + response.body);
    if (response.statusCode == 200) {
      return castDetailsFromJson(response.body);
    } else {
      throw Exception('Failed to load movies');
    }
  }
}
