class Note {
  final int? id;
  final String username;
  final String title;
  final String content;
  final DateTime createdTime;
  final List<String> tags;

  Note({
    this.id, 
    required this.username, 
    required this.title, 
    required this.content, 
    required this.createdTime,
    this.tags = const [],
  });

   Note copyWith({
    int? id,
    String? title,
    String? content,
    String? username,
    DateTime? createdTime,
    List<String>? tags,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      username: username ?? this.username,
      createdTime: createdTime ?? this.createdTime,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'title': title,
      'content': content,
      'createdTime': createdTime.toIso8601String(),
      'tags': tags.join(","),
    };
  }
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      username: map['username'],
      title: map['title'],
      content: map['content'],
      createdTime: DateTime.parse(map['createdTime']),
      tags: (map['tags'] as String).isEmpty 
          ? (map['tags'] as String).split(",") : [],
    );
  }

  copy({required String title, required String content, required String createdTime,}) {}
}