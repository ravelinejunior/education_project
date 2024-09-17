import 'package:education_project/core/common/app/providers/user_provider.dart';
import 'package:education_project/core/res/theme.dart';
import 'package:education_project/core/services/injection_container.dart';
import 'package:education_project/core/services/router.dart';
import 'package:education_project/firebase_options.dart';
import 'package:education_project/src/on_boarding/presentation/on_boarding_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserProvider(),
      child: MaterialApp(
        title: 'Education App',
        theme: mainThemeData(),
        onGenerateRoute: generateRoute,
        debugShowCheckedModeBanner: false,
        initialRoute: OnBoardingScreen.routeName,
      ),
    );
  }
}
