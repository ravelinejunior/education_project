import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/core/common/feature/course/domain/entities/course.dart';
import 'package:education_project/core/utils/typedef.dart';

class CourseModel extends Course {
  const CourseModel({
    required super.id,
    required super.title,
    required super.numberOfExams,
    required super.numberOfMaterials,
    required super.numberOfVideos,
    required super.groupId,
    required super.createdAt,
    super.description,
    super.imageUrl,
    super.imageIsFile = false,
    super.updatedAt,
  });

  factory CourseModel.fromJson(DataMap json) {
    return CourseModel(
      id: json['id'] as String,
      title: json['title'] as String,
      numberOfExams: json['number_of_exams'] as int,
      numberOfMaterials: json['number_of_materials'] as int,
      numberOfVideos: json['number_of_videos'] as int,
      groupId: json['group_id'] as String,
      createdAt: (json['created_at'] as Timestamp).toDate(),
      description: json['description'] as String,
      imageUrl: json['image_url'] as String,
      imageIsFile: json['image_is_file'] as bool,
      updatedAt: (json['updated_at'] as Timestamp).toDate(),
    );
  }

  CourseModel.empty()
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

  CourseModel copyWith({
    String? id,
    String? title,
    int? numberOfExams,
    int? numberOfMaterials,
    int? numberOfVideos,
    String? groupId,
    DateTime? createdAt,
    String? description,
    String? imageUrl,
    bool? imageIsFile,
    DateTime? updatedAt,
  }) {
    return CourseModel(
      id: id ?? this.id,
      title: title ?? this.title,
      numberOfExams: numberOfExams ?? this.numberOfExams,
      numberOfMaterials: numberOfMaterials ?? this.numberOfMaterials,
      numberOfVideos: numberOfVideos ?? this.numberOfVideos,
      groupId: groupId ?? this.groupId,
      createdAt: createdAt ?? this.createdAt,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      imageIsFile: imageIsFile ?? this.imageIsFile,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  DataMap toMap() {
    return {
      'id': id,
      'title': title,
      'number_of_exams': numberOfExams,
      'number_of_materials': numberOfMaterials,
      'number_of_videos': numberOfVideos,
      'group_id': groupId,
      'created_at': FieldValue.serverTimestamp(),
      'description': description,
      'image_url': imageUrl,
      'image_is_file': imageIsFile,
      'updated_at': FieldValue.serverTimestamp(),
    };
  }
}
