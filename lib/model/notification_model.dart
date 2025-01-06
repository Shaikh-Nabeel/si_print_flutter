// models/notification_model.dart
class NotificationModel {
  final String title;
  final String description;
  final String date;

  NotificationModel({
    required this.title,
    required this.description,
    required this.date,
  });

  // Factory method to create an instance from JSON
  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      title: json['title'],
      description: json['description'],
      date: json['date'],
    );
  }
}
