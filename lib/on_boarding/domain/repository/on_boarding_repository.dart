import 'package:education_project/core/utils/typedef.dart';

abstract class OnBoardingRepository {
  ResultFuture<void> cacheFirstTimer();
  ResultFuture<bool> checkIfUserIsFirstTimer();
}
