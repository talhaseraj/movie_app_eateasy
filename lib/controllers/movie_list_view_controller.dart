import 'package:flutter/material.dart';

import '../models/movies_list_response.dart';
import '../services/api_service.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class MovieListViewController extends GetxController {
  final ApiService _apiService = ApiService();

  late ScrollController scrollController;

  List<Movie> movies = [];
  List<int> favoriteMovieIds = [];
  List<int> watchlistMovieIds = [];
  int currentPage = 1;
  bool isLoading = true;

  @override
  void onInit() {
    fetchMovies();
    loadFavorites();
    loadWatchlist();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        fetchMovies();
      }
    });

    super.onInit();
  }

  Future<void> fetchMovies() async {
    isLoading = true;
    update();

    try {
      List<Movie> newMovies = await _apiService.fetchMovies(currentPage);
      movies.addAll(newMovies);
      currentPage++;
    } catch (e) {
      print(e);
    } finally {
      isLoading = false;
      update();
    }
  }

  void addToFavorites(Movie movie) {
    if (!favoriteMovieIds.contains(movie.id)) {
      favoriteMovieIds.add(movie.id ?? 0);
      saveFavorites();
      update();
    }
  }

  void addToWatchlist(Movie movie) {
    if (!watchlistMovieIds.contains(movie.id)) {
      watchlistMovieIds.add(movie.id ?? 0);
      saveWatchlist();
      update();
    }
  }

  Future<void> saveFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList(
        'favoriteMovies', favoriteMovieIds.map((id) => id.toString()).toList());
  }

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    favoriteMovieIds = prefs
            .getStringList('favoriteMovies')
            ?.map((id) => int.parse(id))
            .toList() ??
        [];
    update();
  }

  Future<void> saveWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('watchlistMovies',
        watchlistMovieIds.map((id) => id.toString()).toList());
  }

  Future<void> loadWatchlist() async {
    final prefs = await SharedPreferences.getInstance();
    watchlistMovieIds = prefs
            .getStringList('watchlistMovies')
            ?.map((id) => int.parse(id))
            .toList() ??
        [];
    update();
  }
}
