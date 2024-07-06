class Event {
  final String eventName;
  final String imageUrl;
  final String eventDesc;
  bool isJoin;

  Event({
    required this.eventName,
    required this.imageUrl,
    required this.eventDesc,
    this.isJoin = false, //Is Not Join By Default
  });

  void changeJoinStatus(bool isJoin) {
    this.isJoin = isJoin;
  }

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
        eventName: json['eventName'] as String,
        imageUrl: json['imageUrl'] as String,
        eventDesc: json['eventDesc'] as String,
        isJoin: json['isJoin'] as bool);
  }

  Map<String, dynamic> toJson() => {
        'eventName': eventName,
        'imageUrl': imageUrl,
        'eventDesc': eventDesc,
        'isJoin': isJoin,
      };
}
