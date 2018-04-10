library movie;

import 'package:json_annotation/json_annotation.dart';

part 'movie_map.g.dart';
@JsonSerializable()
class Movie extends Object with _$MovieSerializerMixin {
  Movie(this.title, this.posters);

  String title;
  String posters;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. We pass the map to the generated _$UserFromJson constructor. 
  /// The constructor is named after the source class, in this case User.
  factory Movie.fromJson(Map<String, dynamic> json) => _$MovieFromJson(json);
}