class MySpecificAskModel {
  String id;
  String datetime;
  String name;
  String specificAsk;
  String connectedNames;
  String connectedDate;
  String businessConverted;
  bool checked;
  String statusText;
  String connectedId;
  MySpecificAskModel({
    required this.id,
    required this.datetime,
    required this.name,
    required this.specificAsk,
    required this.connectedNames,
    required this.connectedDate,
    required this.businessConverted,
    required this.checked,
    required this.statusText,
    required this.connectedId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'datetime': datetime,
      'name': name,
      'specificAsk': specificAsk,
      'connectedNames': connectedNames,
      'connectedDate': connectedDate,
      'businessConverted': businessConverted,
      'checked': checked,
      'statusText': statusText,
      'connectedId': connectedId,
    };
  }

  factory MySpecificAskModel.fromMap(Map<String, dynamic> map) {
    return MySpecificAskModel(
      id: map['id'] as String,
      datetime: map['datetime'] as String,
      name: map['name'] as String,
      specificAsk: map['specific_ask'] as String,
      connectedNames: map['connected_names'] as String,
      connectedDate: map['connected_date'] as String,
      businessConverted: map['business_converted'] as String,
      checked: map['checked'] as bool,
      statusText: map['status_text'] as String,
      connectedId: map['connected_id'] as String,
    );
  }
}
