class UserDatas {
  final String id;
  final String userID;
  final String name;
  final String email;
  final String phone;
  final String gender;
  final String status;
  final String credits;

  UserDatas({
    required this.id,
    required this.userID,
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
    required this.status,
    required this.credits,
  });

  factory UserDatas.fromJson(Map<String, dynamic> json) {
    return UserDatas(
      id: json['id'] ?? '',
      userID: json['userID'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phone: json['phone'] ?? '',
      gender: json['gender'] ?? '',
      status: json['status'] ?? '',
      credits: json['credits'] ?? '0',
    );
  }
}

class Invoices {
  final String docID;
  final String description;
  final String date;
  final String file;

  Invoices({
    required this.docID,
    required this.description,
    required this.date,
    required this.file,
  });

  factory Invoices.fromJson(Map<String, dynamic> json) {
    return Invoices(
      docID: json['docID'] ?? '',
      description: json['description'] ?? '',
      date: json['date'] ?? '',
      file: json['file'] ?? '',
    );
  }
}
