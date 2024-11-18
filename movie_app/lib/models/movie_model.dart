class Movie {
  final String title;
  final String image;
  final String summary;

  Movie({required this.title, required this.image, required this.summary});

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['show']['name'],
      image: json['show']['image']?['medium'] ?? '',
      summary: json['show']['summary'] ?? 'No description available.',
    );
  }
}
