class TransactionModel {
  dynamic date;
  String? amount;
  String? selectedDate;
  String? time;
  String? appointmentTime;
  String? uid;

  TransactionModel(
      {this.date,
      this.amount,
      this.selectedDate,
      this.time,
      this.appointmentTime,
      this.uid});

  factory TransactionModel.fromMap(map) {
    return TransactionModel(
      date: map['date'],
      selectedDate: map['selectedDate'],
      time: map['time'],
      appointmentTime: map['appointmentTime'],
      uid: map['uid'],
      amount: map['amount'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "date": date,
      "selectedDate": selectedDate,
      "time": time,
      "appointmentTime": appointmentTime,
      "uid": uid,
      "amount": amount,
    };
  }
}
