import 'package:app_pfe/models/User.dart';
import 'package:app_pfe/models/reclamation.dart';

class FirebaseNotification {
  int id;
  String notification;
  DateTime date;
  String type;
  User sender;
  User receiver;
  Reclamation reclamation;

  FirebaseNotification({
    required this.id,
    required this.notification,
    required this.date,
    required this.type,
    required this.sender,
    required this.receiver,
    required this.reclamation,
  });

  factory FirebaseNotification.fromJson(Map<String, dynamic> json) {
    return FirebaseNotification(
      id: json['id'],
      notification: json['notification'],
      date: DateTime.parse(json['date']),
      type: json['type'],
      sender: User.fromJson(json['sender']),
      receiver: User.fromJson(json['receiver']),
      reclamation: Reclamation.fromJson(json['reclamation']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'notification': notification,
      'date': date.toIso8601String(),
      'type': type,
      'sender': sender.toJson(),
      'receiver': receiver.toJson(),
      'reclamation': reclamation.toJson(),
    };
  }
}
