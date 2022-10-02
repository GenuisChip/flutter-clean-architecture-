import 'package:products_clean_architecture/layers/domain/entities/post_entity.dart';

class Post extends PostEntity {
  Post({
    required super.id,
    required super.title,
    required super.body,
    required super.userId,
    required super.tags,
    required super.reactions,
  });

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        title: json["title"],
        body: json["body"],
        userId: json["userId"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        reactions: json["reactions"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "body": body,
        "userId": userId,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "reactions": reactions,
      };

  static List<Post> fromJsonList(List json) {
    return List.from(json.map((p) => Post.fromJson(p)));
  }
}
