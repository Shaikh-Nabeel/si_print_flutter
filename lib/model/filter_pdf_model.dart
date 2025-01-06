class PdfData {
  final String docID;
  final String sourceID;
  final String owner;
  final String description;
  final String label;
  final String date;
  final String file;
  final String status;
  final String sourceName;

  PdfData({
    required this.docID,
    required this.sourceID,
    required this.owner,
    required this.description,
    required this.label,
    required this.date,
    required this.file,
    required this.status,
    required this.sourceName,
  });

  factory PdfData.fromJson(Map<String, dynamic> json) {
    return PdfData(
      docID: json['docID'],
      sourceID: json['sourceID'],
      owner: json['owner'],
      description: json['description'],
      label: json['label'],
      date: json['date'],
      file: json['file'],
      status: json['status'],
      sourceName: json['source_name'],
    );
  }
}

