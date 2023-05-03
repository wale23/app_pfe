import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/models/reclamation.dart';

class Comments {
  int? id;
  DateTime? date;
  String? comment;
  Reclamation? reclamation;
  User? user;
  Comments({
    this.id,
    this.date,
    this.comment,
    this.reclamation,
    this.user,
  });
  factory Comments.fromJson(Map<String, dynamic> json) {
    return Comments(
      id: json['id'],
      date: DateTime.parse(json['date']),
      comment: json['comment'],
      reclamation: Reclamation.fromJson(json['reclamation']),
      user: User.fromJson(json['user']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'comment': comment,
      'reclamation': reclamation?.toJson(),
      'user': user?.toJson(),
    };
  }
}
