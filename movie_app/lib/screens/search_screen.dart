import 'package:flutter/material.dart';
import '../services/api_service.dart';
import '../models/movie_model.dart';
import '../widgets/movie_card.dart';
import 'details_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  Future<List<Movie>>? searchResults;

  void searchMovies(String searchTerm) {
    setState(() {
      query = searchTerm;
      searchResults = ApiService.fetchMovies(searchTerm).then((data) =>
          data.map((movieJson) => Movie.fromJson(movieJson)).toList());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          decoration: const InputDecoration(
            hintText: 'Search Movies',
            border: InputBorder.none,
          ),
          onSubmitted: searchMovies,
        ),
      ),
      body: query.isEmpty
          ? const Center(child: Text('Start typing to search for movies'))
          : FutureBuilder<List<Movie>>(
        future: searchResults,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data == null || snapshot.data!.isEmpty) {
            return const Center(child: Text('No results found'));
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: snapshot.data![index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            DetailsScreen(movie: snapshot.data![index]),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}
