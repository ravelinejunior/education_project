import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:education_project/core/common/feature/course/data/model/course_model.dart';
import 'package:education_project/core/common/feature/course/domain/entities/course.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

abstract class CourseRemoteDataSrc {
  const CourseRemoteDataSrc();
  Future<List<CourseModel>> getCourses();
  Future<void> addCourse(Course course);
}

class CourseRemoteDataSrcImpl implements CourseRemoteDataSrc {
  const CourseRemoteDataSrcImpl({
    required this.firestore,
    required this.storage,
    required this.auth,
  });

  final FirebaseFirestore firestore;
  final FirebaseStorage storage;
  final FirebaseAuth auth;

  @override
  Future<List<CourseModel>> getCourses() async {
    //TODO(get courses from firebase)
    throw UnimplementedError();
  }

  @override
  Future<void> addCourse(Course course) async {
    //TODO(add course to firebase)
    throw UnimplementedError();
  }
}
