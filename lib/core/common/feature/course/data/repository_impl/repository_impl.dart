import 'package:dartz/dartz.dart';
import 'package:education_project/core/common/feature/course/data/datasource/course_remote_data_src.dart';
import 'package:education_project/core/common/feature/course/domain/entities/course.dart';
import 'package:education_project/core/common/feature/course/domain/repository/course_repository.dart';
import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:education_project/core/utils/typedef.dart';

class CourseRepositoryImpl implements CourseRepository {
  const CourseRepositoryImpl(this._remoteDataSrc);
  final CourseRemoteDataSrc _remoteDataSrc;

  @override
  ResultFuture<void> addCourse(Course course) async {
    try {
      await _remoteDataSrc.addCourse(course);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure.fromException(e),
      );
    }
  }

  @override
  ResultFuture<List<Course>> getCourses() async {
    try {
      final courses = await _remoteDataSrc.getCourses();
      return Right(courses);
    } on ServerException catch (e) {
      return Left(
        ServerFailure.fromException(e),
      );
    }
  }
}
