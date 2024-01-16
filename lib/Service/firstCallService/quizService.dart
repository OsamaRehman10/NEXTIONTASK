import 'package:movie/Model/QuizModel/movie_model.dart';
import 'package:movie/Network/api_base_helper.dart';
import 'package:movie/Network/api_links.dart';

class MovieService {
  static Future<MovieModel> getMovie() async {
    var response = await ApiBaseHelper.httpGetRequest(ApiLinks.movieApi);
    MovieModel movieApiResponse = MovieModel.fromJson(response);
    return movieApiResponse;
  }
}
