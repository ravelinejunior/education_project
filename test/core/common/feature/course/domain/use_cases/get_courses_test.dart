import 'package:dartz/dartz.dart';
import 'package:education_project/core/common/feature/course/domain/entities/course.dart';
import 'package:education_project/core/common/feature/course/domain/repository/course_repository.dart';
import 'package:education_project/core/common/feature/course/domain/use_cases/get_courses.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/course_repo_mock.dart';

void main() {
  late CourseRepository repository;
  late GetCourses getCoursesUseCase;

  final tCourses = [
    Course.empty(),
    Course.empty(),
    Course.empty(),
  ];

  setUp(() {
    repository = MockCourseRepository();
    getCoursesUseCase = GetCourses(repository);
    registerFallbackValue(tCourses);
  });

  test('should get courses from repository', () async {
    // arrange
    when(() => repository.getCourses()).thenAnswer(
      (_) async => Right(await Future.value(tCourses)),
    );

    // act
    final result = await getCoursesUseCase();

    // assert
    expect(result, Right<dynamic, List<Course>>(tCourses));
    verify(() => repository.getCourses()).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return failure from repository', () async {
    // arrange
    when(() => repository.getCourses()).thenAnswer(
      (_) async => const Left(
        ServerFailure(
          message: 'error',
          statusCode: 505,
        ),
      ),
    );

    // act
    final result = await repository.getCourses();

    // assert
    expect(
      result,
      const Left<ServerFailure, List<Course>>(
        ServerFailure(message: 'error', statusCode: 505),
      ),
    );
    verify(() => repository.getCourses()).called(1);
    verifyNoMoreInteractions(repository);
  });
}
