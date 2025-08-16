class Note {
  final int? id;
  final String username;
  final String title;
  final String content;
  final String date;

  Note({this.id, required this.username, required this.title, required this.content, required this.date});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'title': title,
      'content': content,
      'date': date,
    };
  }
  factory Note.fromMap(Map<String, dynamic> map) {
    return Note(
      id: map['id'],
      username: map['username'],
      title: map['title'],
      content: map['content'],
      date: map['date'],
    );
  }
}