import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/models/comment.dart';

class Reclamation {
  int? id;
  String? status;
  String? subject;
  int? priority;
  DateTime? date;
  String? description;
  List? images;
  bool? archived;
  User? user;
  List<Comments>? comments;
  Reclamation({
    this.id,
    this.status,
    this.subject,
    this.priority,
    this.date,
    this.description,
    this.images,
    this.archived,
    this.user,
    this.comments,
  });
  factory Reclamation.fromJson(Map<String, dynamic> json) {
    return Reclamation(
      id: json['id'],
      status: json['status'],
      subject: json['subject'],
      priority: json['priority'],
      date: DateTime.parse(json['date']),
      description: json['description'],
      images: List<dynamic>.from(json['images']),
      archived: json['archived'],
      user: User.fromJson(json['user']),
      comments: json['comments'] == null ? [] : List<Comments>.from(json['comments']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status,
      'subject': subject,
      'priority': priority,
      'date': date,
      'description': description,
      'images': images,
      'archived': archived,
      'user_id': user?.id,
      'comments': comments,
    };
  }
}
