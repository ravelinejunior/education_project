import 'package:education_project/core/common/views/loading_view.dart';
import 'package:education_project/core/common/widgets/gradient_background.dart';
import 'package:education_project/core/res/icons.dart';
import 'package:education_project/on_boarding/domain/models/page_content_model.dart';
import 'package:education_project/on_boarding/presentation/on_boarding/components/on_boarding_page.dart';
import 'package:education_project/on_boarding/presentation/on_boarding/cubit/on_boarding_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  static const String routeName = '/';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    //BlocProvider.of<OnBoardingCubit>(context).checkIfUserIsFirstTimer();
    context.read<OnBoardingCubit>().checkIfUserIsFirstTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      body: GradientBackground(
        image: MediaRes.whiteBackground,
        child: BlocConsumer<OnBoardingCubit, OnBoardingCubitState>(
          listener: (context, state) {
            if (state is OnBoardingStatus && !state.isFirstTimer) {
              Navigator.pushReplacementNamed(context, '/home');
            }
          },
          builder: (context, state) {
            if (state is OnBoardingError) {
              return const LoadingView();
            } else if (state is CachingFirstTimer ||
                state is CheckingIfUserIsFirstTimer) {
              return const LoadingView();
            } else if (state is UserCached) {
              return const LoadingView();
            } else {
              return Stack(
                children: [
                  Align(
                    child: PageView(
                      controller: _pageController,
                      children: const [
                        OnBoardingPage(
                          pageContent: PageContentModel.first(),
                        ),
                        OnBoardingPage(
                          pageContent: PageContentModel.second(),
                        ),
                        OnBoardingPage(
                          pageContent: PageContentModel.third(),
                        ),
                        OnBoardingPage(
                          pageContent: PageContentModel.fourth(),
                        ),
                        OnBoardingPage(
                          pageContent: PageContentModel.fifth(),
                        ),
                      ],
                    ),
                  ),

                  // SmothiePageIndicator
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: SmoothPageIndicator(
                        controller: _pageController,
                        count: 5,
                        effect: const ExpandingDotsEffect(
                          dotHeight: 8,
                          dotWidth: 8,
                          dotColor: Color.fromARGB(137, 44, 44, 44),
                          activeDotColor: Colors.white,
                        ),
                        onDotClicked: (index) {
                          setState(() {
                            _currentPage = index;
                            _pageController.animateToPage(
                              _currentPage,
                              duration: const Duration(milliseconds: 400),
                              curve: Curves.easeInOut,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
