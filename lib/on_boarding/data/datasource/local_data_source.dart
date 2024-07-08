import 'package:education_project/core/errors/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String kFirstTimerKey = 'firstTimerKey';

abstract class OnBoardingLocalDataSource {
  const OnBoardingLocalDataSource();
  Future<void> cacheFirstTimer();

  Future<bool> checkIfUserIsFirstTimer();
}

class OnBoardingLocalDataSourceImpl implements OnBoardingLocalDataSource {
  const OnBoardingLocalDataSourceImpl({required this.prefs});

  final SharedPreferences prefs;
  @override
  Future<void> cacheFirstTimer() async {
    try {
      await prefs.setBool(kFirstTimerKey, false);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<bool> checkIfUserIsFirstTimer() async {
    try {
      return prefs.getBool(kFirstTimerKey) ?? true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
