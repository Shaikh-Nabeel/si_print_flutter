class SmsModel {
  int smsID;
  String sourceID;
  String owner;
  String description;
  String label;
  String date;
  String status;

  SmsModel({
    required this.smsID,
    required this.sourceID,
    required this.owner,
    required this.description,
    required this.label,
    required this.date,
    required this.status,
  });

  factory SmsModel.fromJson(Map<String, dynamic> json) {
    return SmsModel(
      smsID: int.parse(json['smsID']),
      sourceID: json['sourceID'],
      owner: json['owner'],
      description: json['description'],
      label: json['label'],
      date: json['date'],
      status: json['status'],
    );
  }
}
