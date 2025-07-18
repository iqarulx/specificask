class SpecificAskModel {
  int count;
  String id;
  String datetime;
  String name;
  String specificAsk;
  bool connected;
  String convertToBusiness;
  SpecificAskModel({
    required this.count,
    required this.id,
    required this.datetime,
    required this.name,
    required this.specificAsk,
    required this.connected,
    required this.convertToBusiness,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'count': count,
      'id': id,
      'datetime': datetime,
      'name': name,
      'specificAsk': specificAsk,
      'connected': connected,
      'convertToBusiness': convertToBusiness,
    };
  }

  factory SpecificAskModel.fromMap(Map<String, dynamic> map) {
    return SpecificAskModel(
      count: map['count'] as int,
      id: map['id'] as String,
      datetime: map['datetime'] as String,
      name: map['name'] as String,
      specificAsk: map['specific_ask'] as String,
      connected: map['connected'] as bool,
      convertToBusiness: map['convert_to_business'].toString(),
    );
  }
}
