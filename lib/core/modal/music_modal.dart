// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// MusicModal class
class MusicModal {
  final int id;
  final String name;
  final String title;
  final String image;
  final String color;
  final String url;
  final bool isFavorite;

  MusicModal({
    required this.id,
    required this.name,
    required this.title,
    required this.image,
    required this.color,
    required this.url,
    required this.isFavorite,
  });

  MusicModal copyWith({
    int? id,
    String? name,
    String? title,
    String? image,
    String? color,
    String? url,
    bool? isFavorite,
  }) {
    return MusicModal(
      id: id ?? this.id,
      name: name ?? this.name,
      title: title ?? this.title,
      image: image ?? this.image,
      color: color ?? this.color,
      url: url ?? this.url,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'title': title,
      'image': image,
      'color': color,
      'url': url,
      'isFavorite': isFavorite,
    };
  }

  factory MusicModal.fromMap(Map<String, dynamic> map) {
    return MusicModal(
      id: map['id'] as int,
      name: map['name'] as String,
      title: map['title'] as String,
      image: map['image'] as String,
      color: map['color'] as String,
      url: map['url'] as String,
      isFavorite: map['isFavorite'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory MusicModal.fromJson(String source) =>
      MusicModal.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'MusicModal(id: $id, name: $name, title: $title, image: $image, color: $color, url: $url, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(covariant MusicModal other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.title == title &&
        other.image == image &&
        other.color == color &&
        other.url == url &&
        other.isFavorite == isFavorite;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        title.hashCode ^
        image.hashCode ^
        color.hashCode ^
        url.hashCode ^
        isFavorite.hashCode;
  }
}
