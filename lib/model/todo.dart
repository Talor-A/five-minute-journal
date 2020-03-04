import 'log.dart';

abstract class Todo {
  static isTodo(Log log) => log.type == 'todo';

  static discard(Log log) {
    log.status = TodoStatus.discarded;
    log.completedDate = null;
  }

  static toggle(Log log) {
    if (log.status == TodoStatus.complete) {
      uncheck(log);
    } else {
      checkOff(log);
    }
  }

  static checkOff(Log log) {
    log.status = TodoStatus.complete;
    log.completedDate = DateTime.now();
  }

  static uncheck(Log log) {
    log.status = TodoStatus.incomplete;
    log.completedDate = null;
  }

  static bool isComplete(Log log) {
    return log.status == TodoStatus.complete;
  }

  static bool isIncomplete(Log log) {
    return log.status == TodoStatus.incomplete;
  }

  static bool isDiscarded(Log log) {
    return log.status == TodoStatus.discarded;
  }
}
