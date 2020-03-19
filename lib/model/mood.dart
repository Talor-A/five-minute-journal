import 'log.dart';

abstract class Mood {
  static isMood(Log log) => log.type == 'mood';

  static add(Log log, String mood) {
    if (!contains(log, mood)) log.text += " $mood";
  }

  static remove(Log log, String mood) {
    var list = log.text.split(" ");
    list..removeWhere((test) => test == mood);
    log.text = list.join(" ");
  }

  static bool contains(Log log, String mood) {
    return log.text.split(" ").contains(mood);
  }
}
