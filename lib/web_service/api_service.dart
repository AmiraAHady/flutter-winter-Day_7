import 'package:day_7/model/movie.dart';
import 'package:day_7/model/product.dart';
import 'package:dio/dio.dart';

class ApiService {
  // final Dio _dio = Dio();
  final Dio _dio = Dio(BaseOptions(baseUrl: 'https://fakestoreapi.com'));

  Future<List<Movie>> getMovies(int pageNumber) async {
    // Map<String,dynamic> data={
    //   'movies':List<Movie>,
    //   'pages':response.data['pages'] 
    // }
    try {
      final response = await _dio.get(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=0ab69d58b9382bc390a939b7dbbe713b&page=$pageNumber');
      if (response.statusCode == 200) {
        return (response.data['results'] as List)
            .map((moviejson) => Movie.fromJson(moviejson))
            .toList();
      } else {
        throw Exception('Error  casting data');
      }
    } catch (e) {
      throw Exception('Error getting Data');
    }
  }

  Future<List<Product>> getProducts() async {
    // Error handling
    try {
      final response = await _dio.get('/products');
      // non-blocking
      // async handling
      // then-catch
      if (response.statusCode == 200) {
        return (response.data as List)
            .map((productJson) => Product.fromJson(productJson))
            .toList();
      } else {
        throw Exception('Error  casting data');
      }
    } catch (err) {
      throw Exception('Error getting Data:$err');
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('/products/$id');
      if (response.statusCode == 200) {
        return Product.fromJson(response.data);
      }else{
         throw Exception('Error  casting data');
      }
    } catch (err) {
      throw Exception('Error getting Data:$err');
    }
  }
}
