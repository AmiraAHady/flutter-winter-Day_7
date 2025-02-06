// ignore_for_file: prefer_const_constructors

import 'package:day_7/screens/product_details.dart';
import 'package:day_7/web_service/api_service.dart';
import 'package:day_7/model/movie.dart';
import 'package:day_7/model/product.dart';
import 'package:flutter/material.dart';

class MovieListPage extends StatefulWidget {
  const MovieListPage({super.key});

  @override
  State<MovieListPage> createState() => _MovieListPageState();
}

// LifeCyclehooks
class _MovieListPageState extends State<MovieListPage> {
  late Future<List<Movie>> movies;
  final ScrollController _scrollController = ScrollController();
  int currentPage = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    movies = ApiService().getMovies(currentPage);
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        getMoreMovies();
      } else if (_scrollController.position.pixels <=
          _scrollController.position.minScrollExtent) {
        getBeforeMovies();
      }
    });
  }

  void getMoreMovies() {
    setState(() {
      currentPage++;
      movies = ApiService().getMovies(currentPage);
    });
  }

  void getBeforeMovies() {
    setState(() {
      if (currentPage > 1) {
        currentPage--;
        movies = ApiService().getMovies(currentPage);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('ProductList Page'),
      ),
      body: FutureBuilder<List<Movie>>(
        future: movies,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: CircularProgressIndicator(
              backgroundColor: Colors.blue,
              color: Colors.pink,
            ));
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Exception ${snapshot.error}'),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: Text('No Movies avaliable'),
            );
          }
          return ListView.builder(
            controller: _scrollController,
            itemBuilder: (context, index) {
              final movie = snapshot.data![index];
              return GestureDetector(
                onTap: () {},
                child: Card(
                  margin: EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    children: [
                      Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            image: DecorationImage(
                              image: NetworkImage(
                                  'https://image.tmdb.org/t/p/w500${movie.posterPath}'),
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Expanded(
                          child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            movie.overview,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        ],
                      ))
                    ],
                  ),
                ),
              );
            },
            itemCount: snapshot.data!.length,
          );
        },
      ),
    );
  }
}
