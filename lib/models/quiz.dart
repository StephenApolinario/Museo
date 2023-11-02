class NewQuiz {
  final String id, title, beaconUUID, color;
  final int rssi;
  final List<NewQuestion> questions;
  late bool isCompleted;
  late int score;

  NewQuiz({
    required this.id,
    required this.beaconUUID,
    this.isCompleted = false,
    this.score = 0,
    required this.rssi,
    required this.title,
    required this.questions,
    required this.color,
  });
}

class NewQuestion {
  final String text, color;
  final List<NewOption> options;
  bool isLocked;
  NewOption? selectedOption;

  NewQuestion({
    required this.text,
    required this.options,
    required this.color,
    this.isLocked = false,
    this.selectedOption,
  });
}

class NewOption {
  final String awnser;
  final bool isCorrect;

  NewOption({
    required this.awnser,
    required this.isCorrect,
  });
}
