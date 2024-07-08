part of 'on_boarding_cubit.dart';

abstract class OnBoardingCubitState extends Equatable {
  const OnBoardingCubitState();

  @override
  List<Object> get props => [];
}

final class OnBoardingCubitInitial extends OnBoardingCubitState {
  const OnBoardingCubitInitial();
}

final class CachingFirstTimer extends OnBoardingCubitState {
  const CachingFirstTimer();
}

final class CheckingIfUserIsFirstTimer extends OnBoardingCubitState {
  const CheckingIfUserIsFirstTimer();
}

final class UserCached extends OnBoardingCubitState {
  const UserCached();
}

class OnBoardingStatus extends OnBoardingCubitState {
  const OnBoardingStatus({
    required this.isFirstTimer,
  });

  final bool isFirstTimer;

  @override
  List<Object> get props => [isFirstTimer];
}

class OnBoardingError extends OnBoardingCubitState {
  const OnBoardingError({
    required this.message,
  });

  final String message;

  @override
  List<Object> get props => [message];
}
