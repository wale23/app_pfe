import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/models/comment.dart';

class Reclamation {
  int? id;
  String? status;
  String? subject;
  String? priority;
  String? dep;
  DateTime? date;
  String? description;
  List images;
  bool? archived;
  User sender;
  User receiver;
  List<Comments>? comments;
  Reclamation({
    this.id,
    this.status,
    this.subject,
    this.priority,
    this.date,
    this.description,
    required this.images,
    this.archived,
    required this.sender,
    required this.receiver,
    this.dep,
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
      dep: json['departement'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
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
      'departement': dep,
      'archived': archived,
      'sender': sender.id,
      'receiver': receiver.id,
      'comments': comments,
    };
  }
}
