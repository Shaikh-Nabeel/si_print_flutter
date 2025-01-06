class Transaction {
  final String userId;
  final String amount;
  final String transactionId;
  final String status;
  final String date;

  Transaction({
    required this.userId,
    required this.amount,
    required this.transactionId,
    required this.status,
    required this.date,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      userId: json['userId'],
      amount: json['amount'],
      transactionId: json['transactionId'],
      status: json['status'],
      date: json['date'],
    );
  }
}
