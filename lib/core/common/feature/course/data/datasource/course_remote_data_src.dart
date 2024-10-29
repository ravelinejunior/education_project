import 'package:education_project/core/common/feature/course/data/model/course_model.dart';
import 'package:education_project/core/common/feature/course/domain/entities/course.dart';

abstract class CourseRemoteDataSrc {
  const CourseRemoteDataSrc();
  Future<List<CourseModel>> getCourses();
  Future<void> addCourse(Course course);
}
