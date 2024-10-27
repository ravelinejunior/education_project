import 'package:education_project/core/common/feature/course/domain/entities/course.dart';
import 'package:education_project/core/common/feature/course/domain/repository/course_repository.dart';
import 'package:education_project/core/use_cases/use_case.dart';
import 'package:education_project/core/utils/typedef.dart';

class GetCourses extends UseCaseWithoutParams<List<Course>> {
  GetCourses(this._repository);
  final CourseRepository _repository;
  @override
  ResultFuture<List<Course>> call() {
    return _repository.getCourses();
  }
}
