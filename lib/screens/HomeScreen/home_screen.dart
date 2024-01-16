import 'package:flutter/material.dart';
import 'package:movie/Model/QuizModel/movie_model.dart';
import 'package:movie/Service/get_movie_api.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class MovieListWidget extends StatefulWidget {
  const MovieListWidget({Key? key}) : super(key: key);

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {
  List<Items> favoriteMovies = [];
  // String posterBaseUrl = 'https://image.tmdb.org/t/p/w500/';
  Color heartIconColor = Colors.white;

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(builder: (context, Orientation, ScreenType) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Movie App'),
        ),
        body: FutureBuilder<MovieModel>(
          future: MovieService().getMovieApi(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.items!.length,
                itemBuilder: (context, index) {
                  Items movie = snapshot.data!.items![index];
                  bool isFavorite = favoriteMovies.contains(movie);

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image(
                                image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500/' +
                                      movie.posterPath.toString(),
                                ),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                              top: 8,
                              left: 8,
                              child: Container(
                                alignment: Alignment.center,
                                width: 45,
                                height: 45,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.white),
                                  borderRadius: BorderRadius.circular(
                                      25), // Half of width/height for a perfect circle
                                ),
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 35,
                                  height: 35,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                        25), // Half of width/height for a perfect circle
                                  ),
                                  child: Text(
                                    '${movie.voteAverage!.toInt() ?? 0.0}',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: IconButton(
                                iconSize: 30, // Adjust the size as needed
                                icon: Icon(
                                  isFavorite
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: isFavorite ? Colors.red : Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    if (isFavorite) {
                                      favoriteMovies.remove(movie);
                                    } else {
                                      favoriteMovies.add(movie);
                                    }
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          movie.name ?? 'N/A',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'Rating: ${movie.voteAverage ?? 0.0}',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Center(child: Text('No Data found'));
          },
        ),
      );
    });
  }
}
