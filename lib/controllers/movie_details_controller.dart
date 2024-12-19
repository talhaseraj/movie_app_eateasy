import 'dart:isolate';

import 'package:get/get.dart';
import 'package:movie_app_eateasy/models/cast_details_model.dart';
import 'package:movie_app_eateasy/models/movie_details_model.dart';
import 'package:movie_app_eateasy/services/api_service.dart';
import 'package:movie_app_eateasy/utils/helpers.dart';

class MovieDetailsController extends GetxController {
  final id;
  MovieDetailsController(this.id);
  bool isLoading = true;
  MovieDetails? movieDetails;
  CastDetails? castDetails;

  final apiService = ApiService();
  @override
  void onInit() {
    initalize();
    super.onInit();
  }

  initalize() async {
    isLoading = true;
    update();
    await fetchDetails();
    await fetchCast();
    Helpers.removeLoadingOverLay();
    isLoading = false;
    update();
  }

  fetchDetails() async {
    movieDetails = await apiService.fetchMovieDetails(id);
    update();
  }

  fetchCast() async {
    castDetails = await apiService.fetchMovieCast(id);
    update();
  }
}
