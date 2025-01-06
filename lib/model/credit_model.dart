// credit_model.dart
class CreditModel {
  final String date;
  final String addedLimit;
  final String usedLimit;

  CreditModel({
    required this.date,
    this.addedLimit = '0',
    this.usedLimit = '0',
  });

  factory CreditModel.fromJson(Map<String, dynamic> json) {
    return CreditModel(
      date: json['date'] ?? '',
      addedLimit: json['added_limit'] ?? '0',
      usedLimit: json['used_limit'] ?? '0',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'date': date,
      'added_limit': addedLimit,
      'used_limit': usedLimit,
    };
  }
}

// credit_response_model.dart
class CreditResponseModel {
  final List<CreditModel> data;
  final int status;

  CreditResponseModel({
    required this.data,
    required this.status,
  });

  factory CreditResponseModel.fromJson(Map<String, dynamic> json) {
    return CreditResponseModel(
      data: (json['data'] as List)
          .map((item) => CreditModel.fromJson(item))
          .toList(),
      status: json['status'] ?? 0,
    );
  }
}