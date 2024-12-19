import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app_eateasy/controllers/movie_list_view_controller.dart';
import 'package:movie_app_eateasy/movieapp_theme.dart';
import 'package:movie_app_eateasy/utils/helpers.dart';

import 'movie_detail_view.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MovieListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'TMDB',
          style: TextStyle(color: MovieappTheme.c_89CCA5),
        ),
        backgroundColor: MovieappTheme.primaryAppColor,
        actions: [
          InkWell(
            child: Badge(
              label: Text("1"),
              child: Icon(
                Icons.notifications,
                color: Colors.white,
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.search,
              color: MovieappTheme.c_02B4E4,
            ),
          )
        ],
      ),
      body: GetBuilder<MovieListViewController>(
        init: MovieListViewController(),
        builder: (_) {
          if (!_.internet) {
            return Text("no internet");
          }
          if (_.isLoading && _.movies.isEmpty) {
            return Center(child: CircularProgressIndicator());
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Favorite Movies",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    shrinkWrap: true,
                    itemCount: _.favoriteMovieIds.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = _.movies
                          .firstWhere((e) => e.id == _.favoriteMovieIds[index]);
                      return InkWell(
                        onTap: () {
                          Helpers.addLoadingOverlay(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailView(movie: movie),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 100,
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                movie.title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(${movie.releaseDate!.year})",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Divider(),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Watchlist Movies",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 200,
                child: ListView.builder(
                    padding: EdgeInsets.only(left: 10),
                    shrinkWrap: true,
                    itemCount: _.watchlistMovieIds.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final movie = _.movies.firstWhere(
                          (e) => e.id == _.watchlistMovieIds[index]);
                      return InkWell(
                        onTap: () {
                          Helpers.addLoadingOverlay(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailView(movie: movie),
                            ),
                          );
                        },
                        child: SizedBox(
                          width: 100,
                          height: 200,
                          child: Column(
                            children: [
                              SizedBox(
                                height: 140,
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                                  ),
                                ),
                              ),
                              Spacer(),
                              Text(
                                movie.title.toString(),
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                "(${movie.releaseDate!.year})",
                                style: TextStyle(color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
              Divider(),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  controller: _.scrollController,
                  children: List.from(
                    _.movies.map(
                      (movie) => ListTile(
                        title: Text(movie.title ?? ""),
                        subtitle: Text('Rating: ${movie.voteAverage}'),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Hero(
                            tag: movie.id.toString(),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}',
                              progressIndicatorBuilder: (ctx, str, indicator) {
                                return CupertinoActivityIndicator();
                              },
                            ),
                          ),
                        ),
                        onTap: () {
                          Helpers.addLoadingOverlay(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  MovieDetailView(movie: movie),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
