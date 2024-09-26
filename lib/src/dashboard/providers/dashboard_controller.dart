import 'package:education_project/core/common/app/providers/tab_navigator.dart';
import 'package:education_project/core/common/views/persistent_view.dart';
import 'package:education_project/src/profile/presentation/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

/// A class that controls the state of the dashboard.
///
/// This class holds the screens and the current index of the dashboard. It
/// also provides methods to change the index, go back and reset the index.
///
/// The [screens] getter returns the list of screens.
///
/// The [currentIndex] getter returns the current index.
///
/// The [changeIndex] method changes the current index to the given index.
///
/// The [goBack] method goes back to the previous index.
///
/// The [resetIndex] method resets the index to 0.
class DashboardController extends ChangeNotifier {
  List<int> _indexHistory = [0];
  final List<Widget> _screens = [
    ChangeNotifierProvider(
      create: (context) => TabNavigator(
        TabItem(
          child: const SizedBox(
            child: Center(
              child: Text(
                'Home',
              ),
            ),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (context) => TabNavigator(
        TabItem(
          child: const SizedBox(
            child: Center(
              child: Text(
                'Materials',
              ),
            ),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (context) => TabNavigator(
        TabItem(
          child: const SizedBox(
            child: Center(
              child: Text(
                'Chat',
              ),
            ),
          ),
        ),
      ),
      child: const PersistentView(),
    ),
    ChangeNotifierProvider(
      create: (context) => TabNavigator(
        TabItem(
          child: const ProfileView(),
        ),
      ),
      child: const PersistentView(),
    ),
  ];

  List<Widget> get screens => _screens;
  int _currentIndex = 0;

  int get currentIndex => _currentIndex;

  void changeIndex(int index) {
    if (_currentIndex == index) return;
    _currentIndex = index;
    _indexHistory.add(index);
    notifyListeners();
  }

  void goBack() {
    if (_indexHistory.length == 1) return;
    _indexHistory.removeLast();
    _currentIndex = _indexHistory.last;
    notifyListeners();
  }

  void resetIndex() {
    _indexHistory = [0];
    _currentIndex = 0;
    notifyListeners();
  }
}
