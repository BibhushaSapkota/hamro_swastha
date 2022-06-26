class MessageModel {
  String? messageId;
  String? sender;
  String? text;
  bool? seen;
  DateTime? createdOn;

  MessageModel(
      {this.messageId, this.sender, this.text, this.createdOn, this.seen});

  MessageModel.fromMap(Map<String, dynamic> map) {
    sender = map['sender'];
    text = map['text'];
    seen = map['seen'];
    messageId = map['messageId'];
    createdOn = map['createdOn'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'sender': sender,
      'text': text,
      'createdOn': createdOn,
      'seen': seen,
      'messageId': messageId,
    };
  }
}
