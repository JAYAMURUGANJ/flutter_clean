import 'package:flutter/material.dart';
import 'package:news_app_clean_architecture/config/common/widgets/network_aware.dart';

import '../../../../config/common/class/local_storage.dart';
import '../widgets/favorite_temple_selection.dart';
import '../widgets/language_widget.dart';
import '../widgets/theme_selection.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final List<Widget> _onBoardingScreens = const [
    LanguageCard(),
    ThemeSelectionWidget(),
    FavoriteTemplesSelection(),
  ];
  final ValueNotifier<int> _currentPage = ValueNotifier(0);
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return NetworkAware(
      child: SafeArea(
          child: ValueListenableBuilder<int>(
              valueListenable: _currentPage,
              builder: (context, currentIndex, child) {
                return Scaffold(
                  body: Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: PageView.builder(
                      controller: _pageController,
                      itemCount: _onBoardingScreens.length,
                      onPageChanged: (value) {
                        _currentPage.value = value;
                      },
                      itemBuilder: (context, index) {
                        return _onBoardingScreens[index];
                      },
                    ),
                  ),
                  bottomNavigationBar: SizedBox(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: List.generate(
                              _onBoardingScreens.length,
                              (index) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 3),
                                    child: CircleAvatar(
                                      radius: currentIndex == index ? 5 : 4,
                                      backgroundColor: currentIndex == index
                                          ? Theme.of(context)
                                              .colorScheme
                                              .primary
                                          : Colors.grey,
                                    ),
                                  )),
                        ),
                        Padding(
                          padding:
                              (currentIndex != (_onBoardingScreens.length - 1))
                                  ? const EdgeInsets.symmetric(
                                      horizontal: 16.0, vertical: 16)
                                  : const EdgeInsets.only(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              if (currentIndex !=
                                  (_onBoardingScreens.length - 1))
                                MaterialButton(
                                    height: 50,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: const StadiumBorder(),
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, "Home");
                                      Prefs.setBool(spOnBoardingStatus, false);
                                    },
                                    child: const Text("Skip",
                                        style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold))),
                              SizedBox(
                                width: (currentIndex ==
                                        (_onBoardingScreens.length - 1))
                                    ? MediaQuery.of(context).size.width
                                    : null,
                                child: Padding(
                                  padding: EdgeInsets.all((currentIndex ==
                                          (_onBoardingScreens.length - 1))
                                      ? 16.0
                                      : 0.0),
                                  child: MaterialButton(
                                    height: 50,
                                    // minWidth: (currentIndex ==
                                    //         (_onBoardingScreens.length - 1))
                                    //     ? MediaQuery.of(context).size.width
                                    //     : null,
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                    shape: const StadiumBorder(),
                                    onPressed: () {
                                      if (currentIndex ==
                                          (_onBoardingScreens.length - 1)) {
                                        Navigator.pushReplacementNamed(
                                            context, "Home");
                                        Prefs.setBool(
                                            spOnBoardingStatus, false);
                                      } else {
                                        _pageController.nextPage(
                                            duration: const Duration(
                                                milliseconds: 100),
                                            curve: Curves.bounceIn);
                                      }
                                    },
                                    child: currentIndex ==
                                            (_onBoardingScreens.length - 1)
                                        ? const Text(
                                            "Get Started",
                                            style: TextStyle(
                                                fontSize: 18,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          )
                                        : const Icon(
                                            Icons.arrow_forward,
                                            size: 24,
                                            color: Colors.white,
                                          ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }
}
