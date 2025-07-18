class PostingModel {
  String postingId;
  String posting;
  PostingModel({
    required this.postingId,
    required this.posting,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'postingId': postingId,
      'posting': posting,
    };
  }

  factory PostingModel.fromMap(Map<String, dynamic> map) {
    return PostingModel(
      postingId: map['posting_id'] as String,
      posting: map['posting'] as String,
    );
  }
}
