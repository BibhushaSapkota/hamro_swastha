class ChatRoomModel {
  String? chatroomId;
  Map<String, dynamic>? participants;
  String? lastMessage;
  DateTime? roomCreated;

  ChatRoomModel(
      {this.chatroomId, this.participants, this.lastMessage, this.roomCreated});

  ChatRoomModel.fromMap(Map<String, dynamic> map) {
    chatroomId = map['chatroomId'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
    roomCreated = map['roomCreated'].toDate();
  }

  Map<String, dynamic> toMap() {
    return {
      'chatroomId': chatroomId,
      'participants': participants,
      'lastMessage': lastMessage,
      'roomCreated': roomCreated,
    };
  }
}
