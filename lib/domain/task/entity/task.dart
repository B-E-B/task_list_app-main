// ignore_for_file: public_member_api_docs, sort_constructors_first
class TaskEntity {
  final String id;
  final String name;
  final bool isCompleted;

  TaskEntity({
    required this.id,
    required this.name,
    required this.isCompleted,
  });

  TaskEntity copyWith({
    String? id,
    String? name,
    bool? isCompleted,
  }) {
    return TaskEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }

  @override
  bool operator ==(covariant TaskEntity other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.isCompleted == isCompleted;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ isCompleted.hashCode;
}
