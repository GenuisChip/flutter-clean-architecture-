class PostEntity {
  PostEntity({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
    required this.tags,
    required this.reactions,
  });

  final int id;
  final String title;
  final String body;
  final int userId;
  final List<String> tags;
  final int reactions;
}
