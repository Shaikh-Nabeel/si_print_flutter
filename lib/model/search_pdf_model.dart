class SearchPdfModel {
  String docID;
  String sourceID;
  String owner;
  String description;
  String label;
  String date;
  String file;
  String status;
  String sourceName;

  SearchPdfModel({
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

  factory SearchPdfModel.fromJson(Map<String, dynamic> json) {
    return SearchPdfModel(
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
