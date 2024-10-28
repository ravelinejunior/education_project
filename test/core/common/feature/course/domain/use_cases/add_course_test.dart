import 'package:dartz/dartz.dart';
import 'package:education_project/core/common/feature/course/domain/entities/course.dart';
import 'package:education_project/core/common/feature/course/domain/repository/course_repository.dart';
import 'package:education_project/core/common/feature/course/domain/use_cases/add_course.dart';
import 'package:education_project/core/errors/failures.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper/course_repo_mock.dart';

void main() {
  late CourseRepository repository;
  late AddCourse addCourseUseCase;

  final tCourse = Course.empty();

  setUp(() {
    repository = MockCourseRepository();
    addCourseUseCase = AddCourse(repository);
    registerFallbackValue(tCourse);
  });

  test('should add course from repository', () async {
    // arrange
    when(() => repository.addCourse(any())).thenAnswer(
      (_) async => const Right(null),
    );
    // act
    await addCourseUseCase(tCourse);
    // assert
    verify(() => repository.addCourse(tCourse)).called(1);
    verifyNoMoreInteractions(repository);
  });

  test('should return failure from repository', () async {
    // arrange
    when(() => repository.addCourse(any())).thenAnswer(
      (_) async => const Left(
        ServerFailure(
          message: 'error',
          statusCode: 0,
        ),
      ),
    );
    // act
    final result = await addCourseUseCase(tCourse);
    // assert
    expect(
      result,
      const Left<Failure, dynamic>(
        ServerFailure(
          message: 'error',
          statusCode: 0,
        ),
      ),
    );
  });
}
