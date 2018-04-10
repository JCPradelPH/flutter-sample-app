// GENERATED CODE - DO NOT MODIFY BY HAND

part of movie;

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) =>
    new Movie(json['title'] as String, json['posters'] as String);

abstract class _$MovieSerializerMixin {
  String get title;
  String get posters;
  Map<String, dynamic> toJson() =>
      <String, dynamic>{'title': title, 'posters': posters};
}
