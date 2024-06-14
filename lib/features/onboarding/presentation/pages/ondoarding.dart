import 'package:flutter/material.dart';
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
    return SafeArea(
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
                  height: 50,
                  child: MaterialButton(
                    color: Theme.of(context).colorScheme.primary,
                    onPressed: () {
                      if (currentIndex == (_onBoardingScreens.length - 1)) {
                        Navigator.pushReplacementNamed(context, "Home");
                        Prefs.setBool(spOnBoardingStatus, false);
                      } else {
                        _pageController.nextPage(
                            duration: const Duration(milliseconds: 100),
                            curve: Curves.bounceIn);
                      }
                    },
                    child: currentIndex == (_onBoardingScreens.length - 1)
                        ? const Text(
                            "Start",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          )
                        : const Icon(
                            Icons.arrow_forward,
                            size: 30,
                            color: Colors.white,
                          ),
                  ),
                ),
              );
            }));
  }
}
