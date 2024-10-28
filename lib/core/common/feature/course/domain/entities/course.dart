import 'package:equatable/equatable.dart';

class Course extends Equatable {
  const Course({
    required this.id,
    required this.title,
    required this.numberOfExams,
    required this.numberOfMaterials,
    required this.numberOfVideos,
    required this.groupId,
    required this.createdAt,
    this.description,
    this.imageUrl,
    this.imageIsFile = false,
    this.updatedAt,
  });

  Course.empty()
      : this(
          id: '_empty.id',
          title: '_empty.title',
          numberOfExams: 0,
          numberOfMaterials: 0,
          numberOfVideos: 0,
          groupId: '_empty.groupId',
          createdAt: DateTime.now(),
          description: '_empty.description',
          imageUrl: '_empty.imageUrl',
          imageIsFile: false,
          updatedAt: DateTime.now(),
        );

  final String id;
  final String title;
  final String? description;
  final int numberOfExams;
  final int numberOfMaterials;
  final int numberOfVideos;
  final String groupId;
  final String? imageUrl;
  final bool imageIsFile;
  final DateTime createdAt;
  final DateTime? updatedAt;

  @override
  List<Object?> get props {
    return [
      id,
    ];
  }
}
