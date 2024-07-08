import 'package:education_project/on_boarding/domain/use_cases/cache_user_first_timer.dart';
import 'package:education_project/on_boarding/domain/use_cases/check_user_is_first_timer.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimerUseCase extends Mock
    implements CacheUserFirstTimerUseCase {}

class MockCheckingIsUserFirstTimerUseCase extends Mock
    implements CheckUserIsFirstTimerUseCase {}
