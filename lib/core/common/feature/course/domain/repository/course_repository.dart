import 'package:education_project/core/common/feature/course/domain/entities/course.dart';
import 'package:education_project/core/utils/typedef.dart';

abstract class CourseRepository {
  ResultFuture<List<Course>> getCourses();
  ResultFuture<void> addCourses(Course course);
}
