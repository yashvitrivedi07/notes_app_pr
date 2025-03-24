class NoteModal {
  String? date, time, title, description;
  int? id;

  NoteModal({this.date, this.description, this.time, this.title, this.id});

  factory NoteModal.toModel(Map m) {
    return NoteModal(
        id: m['id'],
        date: m['date'],
        description: m['description'],
        time: m['time'],
        title: m['title']);
  }
}
