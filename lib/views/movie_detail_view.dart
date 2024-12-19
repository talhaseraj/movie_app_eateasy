import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:movie_app_eateasy/controllers/movie_details_controller.dart';
import 'package:movie_app_eateasy/controllers/movie_list_view_controller.dart';
import 'package:movie_app_eateasy/movieapp_theme.dart';
import '../models/movies_list_response.dart';
import 'package:get/get.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;

  MovieDetailView({required this.movie});

  @override
  Widget build(BuildContext context) {
    final movieListController = Get.find<MovieListViewController>();
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Colors.white,
        ),
        title: Text(
          movie.title.toString(),
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: MovieappTheme.primaryAppColor,
      ),
      body: GetBuilder<MovieDetailsController>(
          init: MovieDetailsController(movie.id),
          builder: (_) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: movie.id.toString(),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            scale: 3,
                            imageUrl:
                                'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                            progressIndicatorBuilder: (q, w, e) {
                              return CupertinoActivityIndicator();
                            },
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            if (!_.isLoading)
                              Text(_.movieDetails!.tagline.toString()),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Text("Rating: "),
                                Text(
                                    "${movie.voteAverage!.toStringAsFixed(1)}"),
                                Icon(
                                  Icons.star_rounded,
                                  color: Colors.amber,
                                  size: 18,
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundColor:
                                      MovieappTheme.primaryAppColor,
                                  child: IconButton(
                                      onPressed: () {
                                        movieListController
                                            .addToFavorites(movie);
                                        Get.snackbar(
                                            "Favorite", "added to favorite");
                                      },
                                      color: Colors.white,
                                      icon: Icon(
                                        size: 15,
                                        Icons.favorite,
                                      )),
                                ),
                                SizedBox(
                                  width: 20,
                                ),
                                CircleAvatar(
                                  backgroundColor:
                                      MovieappTheme.primaryAppColor,
                                  child: IconButton(
                                      onPressed: () {
                                        movieListController
                                            .addToWatchlist(movie);
                                        Get.snackbar("Watch list",
                                            "added to watch list");
                                      },
                                      color: Colors.white,
                                      icon: Icon(
                                        Icons.bookmark,
                                        size: 15,
                                      )),
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Overview",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text('${movie.overview}'),
                  SizedBox(height: 10),
                  Text('Cast:', style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 10),
                  if (!_.isLoading)
                    SizedBox(
                      height: 200,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: _.castDetails!.cast!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final cast = _.castDetails!.cast![index];
                            return SizedBox(
                              width: 150,
                              height: 200,
                              child: Column(
                                children: [
                                  Expanded(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              'https://image.tmdb.org/t/p/w500${cast.profilePath}'),
                                    ),
                                  ),
                                  Text(
                                    cast.name.toString(),
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "(${cast.character.toString()})",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              ),
                            );
                          }),
                    ),
                ],
              ),
            );
          }),
    );
  }
}
