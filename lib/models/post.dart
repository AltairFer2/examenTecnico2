class Post {
  String id;
  String title;
  String body;
  String userId;

  Post({
    required this.id,
    required this.title,
    required this.body,
    required this.userId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      body: json['body'] ?? '',
      userId: json['userId'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': this.title,
      'body': this.body,
      'userId': this.userId,
    };
  }

  Map<String, dynamic> toJsonWithId() {
    return {
      '_id': this.id,
      'title': this.title,
      'body': this.body,
      'userId': this.userId,
    };
  }
}
