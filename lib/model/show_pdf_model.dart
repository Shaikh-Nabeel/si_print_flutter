// models/dashboard_model.dart

class UserData {
  final String? name;
  final String? email;
  final String? phone;
  final String? photo;
  final String? selfUpload;
  final String? partyUpload;

  UserData({
    this.name,
    this.email,
    this.phone,
    this.photo,
    this.selfUpload,
    this.partyUpload,
  });

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'] ?? 'Guest User',
      email: json['email'] ?? 'guest@example.com',
      phone: json['phone'] ?? 'N/A',
      photo: json['photo'] ?? '',
      selfUpload: json['selfUpload'] ?? '0',
      partyUpload: json['partyUpload'] ?? '0',
    );
  }
}

class Invoice {
  final String? docID;
  final String? label;
  final String? date;
  final String? file;

  Invoice({
     this.docID,
     this.label,
     this.date,
     this.file,
  });

  factory Invoice.fromJson(Map<String, dynamic> json) {
    return Invoice(
      docID: json['docID'],
      label: json['label'],
      date: json['date'],
      file: json['file'],
    );
  }
}






//
// class UserData {
//   final String? name;
//   final String? email;
//   final String? phone;
//   final String? photo;
//   final String? selfUpload;
//   final String? partyUpload;
//
//   UserData({
//     this.name,
//     this.email,
//     this.phone,
//     this.photo,
//     this.selfUpload,
//     this.partyUpload,
//   });
//
//   factory UserData.fromJson(Map<String, dynamic> json) {
//     return UserData(
//       name: json['name'] ?? 'Guest User',
//       email: json['email'] ?? 'guest@example.com',
//       phone: json['phone'] ?? 'N/A',
//       photo: json['photo'] ?? '',
//       selfUpload: json['selfUpload'] ?? '0',
//       partyUpload: json['partyUpload'] ?? '0',
//     );
//   }
// }
//
// class Invoice {
//   final String? docID;
//   final String? label;
//   final String? date;
//   final String? file;
//
//   Invoice({
//     this.docID,
//     this.label,
//     this.date,
//     this.file,
//   });
//
//   factory Invoice.fromJson(Map<String, dynamic> json) {
//     return Invoice(
//       docID: json['docID'] ?? 'Unknown',
//       label: json['label'] ?? 'No Label',
//       date: json['date'] ?? 'N/A',
//       file: json['file'] ?? '',
//     );
//   }
// }
