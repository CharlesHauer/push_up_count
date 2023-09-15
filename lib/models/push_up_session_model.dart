class PushUpSession {
  final int id;
  final int numberPushUp;
  final String sessionDate;


  const PushUpSession({
    required this.id,
    required this.numberPushUp,
    required this.sessionDate,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'numberPushUp': numberPushUp,
      'sessionDate': sessionDate,
    };
  }

}