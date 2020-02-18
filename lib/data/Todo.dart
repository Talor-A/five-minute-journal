enum TodoStatus {
  complete,
  incomplete,
  discarded,
}

class Todo {
  String text;
  TodoStatus status;

  discard() {
    this.status = TodoStatus.discarded;
  }

  checkOff() {
    this.status = TodoStatus.complete;
  }

  uncheck() {
    this.status = TodoStatus.incomplete;
  }

  bool isComplete() {
    return this.status == TodoStatus.complete;
  }

  bool isIncomplete() {
    return this.status == TodoStatus.incomplete;
  }

  bool isDiscarded() {
    return this.status == TodoStatus.discarded;
  }
}
