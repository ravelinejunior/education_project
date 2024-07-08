import 'package:education_project/core/errors/exceptions.dart';
import 'package:education_project/on_boarding/data/datasource/local_data_source.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'shared_prefs.mock.dart';

void main() {
  late SharedPreferences sharedPreferences;
  late OnBoardingLocalDataSourceImpl dataSourceImpl;

  setUp(
    () {
      sharedPreferences = MockSharedPreference();
      dataSourceImpl = OnBoardingLocalDataSourceImpl(prefs: sharedPreferences);
    },
  );

  group(
    'cacheFirstTimer',
    () {
      test(
        'should call [SharedPreferences] to cache and verify if is called',
        () async {
          // Arrange
          when(() => sharedPreferences.setBool(any(), any())).thenAnswer(
            (_) async => true,
          );
          // Act
          await dataSourceImpl.cacheFirstTimer();
          // Assert
          verify(() => sharedPreferences.setBool(kFirstTimerKey, false));
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test(
        'should throw a CacheException if [SharedPreferences] throws an '
        'exception',
        () async {
          // Arrange
          when(
            () => sharedPreferences.setBool(
              any(),
              any(),
            ),
          ).thenThrow(
            Exception(),
          );
          // Act
          final call = dataSourceImpl.cacheFirstTimer;
          // Assert
          expect(call, throwsA(isA<CacheException>()));
        },
      );
    },
  );

  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'should call [SharedPreferences] to check if user is first timer and '
        'return the right response when user exists',
        () async {
          when(() => sharedPreferences.get(any())).thenReturn(true);

          final result = await dataSourceImpl.checkIfUserIsFirstTimer();

          expect(result, true);
          verify(
            () => sharedPreferences.getBool(kFirstTimerKey),
          );
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test(
        'should return true if there is no data stored',
        () async {
          // Arrange
          when(() => sharedPreferences.getBool(any())).thenReturn(null);
          // Act
          final result = await dataSourceImpl.checkIfUserIsFirstTimer();
          // Assert
          expect(result, true);
          verify(
            () => sharedPreferences.getBool(kFirstTimerKey),
          );
          verifyNoMoreInteractions(sharedPreferences);
        },
      );

      test(
        'should throw [CacheException] when call is unsuccessfull',
        () async {
          // Arrange
          when(() => sharedPreferences.getBool(any())).thenThrow(Exception());
          // Act
          final call = dataSourceImpl.checkIfUserIsFirstTimer;
          // Assert
          expect(call, throwsA(isA<CacheException>()));
          verify(
            () => sharedPreferences.getBool(kFirstTimerKey),
          ).called(1);
          verifyNoMoreInteractions(sharedPreferences);
        },
      );
    },
  );
}
