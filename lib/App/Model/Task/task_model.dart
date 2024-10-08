class TaskModel {
  String heading;
  String details;
  dynamic dueDate;  // This can hold both a DateTime object or a String
  bool isCompleted;

  TaskModel({
    required this.heading,
    required this.details,
    required this.dueDate,
    this.isCompleted = false,
  });

  Map<String, dynamic> toJson() => {
    'heading': heading,
    'details': details,
    'dueDate': dueDate,  // stored as dynamic
    'isCompleted': isCompleted,
  };

  static TaskModel fromJson(Map<String, dynamic> json) {
    return TaskModel(
      heading: json['heading'],
      details: json['details'],
      dueDate: json['dueDate'],  // loaded as dynamic (likely string)
      isCompleted: json['isCompleted'],
    );
  }
}
