import 'package:app_pfe/models/User.dart';

class Comments {
  int? id;
  DateTime? date;
  String? comment;
  User? user;
  Comments({
    this.id,
    this.date,
    this.comment,
    this.user,
  });
  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'],
      date: DateTime.parse(json['date']),
      comment: json['comment'],
      user: User.fromJson(json['user']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'comment': comment,
      'user': user?.toJson(),
    };
  }
}
