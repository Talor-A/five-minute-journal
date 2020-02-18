import 'Todo.dart';

final months = {
  1: 'Jan',
  2: 'Feb',
  3: 'Mar',
  4: 'Apr',
  5: 'May',
  6: 'Jun',
  7: 'Jul',
  8: 'Aug',
  9: 'Sep',
  10: 'Oct',
  11: 'Nov',
  12: 'Dec',
};

final days = {
  1: 'Monday',
  2: 'Tuesday',
  3: 'Wednesday',
  4: 'Thursday',
  5: 'Friday',
  6: 'Saturday',
  7: 'Sunday',
};

class Entry {
  String content;

  List<String> notes;
  List<Todo> todos;

  DateTime creationDate;

  Entry({title, content, creationDate}) {
    this.creationDate = DateTime.now();
    this.content = content != null ? content : '';
  }
  set title(_) {}
  String get title {
    return "${months[creationDate.month]} ${creationDate.day}";
  }

  String getDateString() =>
      "${days[creationDate.weekday]} " +
      "${months[creationDate.month]} ${creationDate.day}, ${creationDate.year} @ " +
      "${creationDate.hour}:${creationDate.minute.toString().padLeft(2, "0")}";
}

Entry createEntry(int daysFromNow) {
  var e = Entry(
    content: '''change me! 
text entries will autosave.
also try creating a new entry with the + button on the list screen. 😉''',
  );
  e.creationDate = DateTime.now().subtract(new Duration(days: daysFromNow));
  return e;
}
