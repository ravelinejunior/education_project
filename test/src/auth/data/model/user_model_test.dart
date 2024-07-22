import 'dart:convert';

import 'package:education_project/core/utils/typedef.dart';
import 'package:education_project/src/auth/data/model/user_model.dart';
import 'package:education_project/src/auth/domain/entity/local_user.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tUserModel = LocalUserModel.empty();
  final tMap = jsonDecode(fixture('user_model.json')) as Datamap;

  test('should be a subclass of LocalUser', () {
    expect(tUserModel, isA<LocalUser>());
  });

  group('fromMap', () {
    test(
        'should return a valid model when JSON is valid and ensure '
        'is [LocalUserModel]', () async {
      // arrange
      // act
      final result = LocalUserModel.fromMap(tMap);
      // assert
      expect(result, isA<LocalUserModel>());
      expect(result, equals(tUserModel));
    });

    test('should throw an [Error] when the map is invalid', () async {
      // arrange
      final invalidMap = Datamap.from(tMap)..remove('uid');
      // act
      const call = LocalUserModel.fromMap;
      // assert
      expect(() => call(invalidMap), throwsA(isA<Error>()));
    });
  });

  group('toMap', () {
    test('should return a valid [Datamap] when the model is valid', () async {
      // arrange
      // act
      final result = tUserModel.toMap();
      // assert
      expect(result, equals(tMap));
    });
  });

  group('copyWith', () {
    test(
      'should return a valid [LocalUserModel] with values updated',
      () async {
        // arrange
        // act
        final result = tUserModel.copyWith(
          fullName: 'updatedFullName',
          email: 'updatedEmail',
        );
        // assert
        expect(result, isA<LocalUserModel>());
        expect(result.fullName, equals('updatedFullName'));
        expect(result.email, equals('updatedEmail'));
      },
    );
  });
}
