import 'package:flutter/material.dart';
import '../models/movies_list_response.dart';

class MovieDetailView extends StatelessWidget {
  final Movie movie;

  MovieDetailView({required this.movie});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(movie.title.toString())),
      body: ListView(
        // mainAxisSize: MainAxisSize.min,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network('https://image.tmdb.org/t/p/w500${movie.posterPath}'),
          SizedBox(height: 10),
          Text('Rating: ${movie.voteAverage}', style: TextStyle(fontSize: 20)),
          SizedBox(height: 10),
          Text('Overview: ${movie.overview}'),
          SizedBox(height: 10),
          Text('Cast:', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 10),
          // ...movie.cast.map((cast) => Row(
          //       children: [
          //         Image.network(
          //             'https://image.tmdb.org/t/p/w500${cast.profilePath}',
          //             width: 50,
          //             height: 50),
          //         SizedBox(width: 10),
          //         Text(cast.name),
          //       ],
          //     )),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Add to Favorites logic
                },
                child: Text('Add to Favorites'),
              ),
              ElevatedButton(
                onPressed: () {
                  // Add to Watchlist logic
                },
                child: Text('Add to Watchlist'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
