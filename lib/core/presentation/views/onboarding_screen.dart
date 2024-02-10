import 'package:Trackefi/core/presentation/themes/light_theme.dart';
import 'package:Trackefi/features/settings/domain/usecase/set_existing_user_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final int _numPages = 6;
  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;
  // final preferences = Preferences.getInstance();

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
          color: isActive ? TColors.main : Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: TColors.main, width: 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.8,
              child: PageView(
                physics: const ClampingScrollPhysics(),
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                children: const <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Create Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Create a category using a unique name and choose a distinctive color.\nYou can input relevant keywords for automatic transaction categorization.',
                        // style: onboardingSubtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Image(
                              height: 500,
                              image: AssetImage(
                                  'assets/categories_screenshot.png'))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Import CSV File',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Import your CSV file and then edit the csv import settings to enable trackefi to properly the file',
                        // style: onboardingSubtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Image(
                              height: 500,
                              image: AssetImage(
                                  'assets/import_settings_screenshot.png'))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Report Generation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'After you have imported your files, make your way to the report generation page and customise the report settings.\nYou can tell trackefi to only look over a certain date period rather the entire files',
                        // style: onboardingSubtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Image(
                              height: 500,
                              image: AssetImage(
                                  'assets/report_settings_screenshot.png'))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Report Generation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'Once you proceed from the report settings trackefi will identify all transactions that it could not\ncategorise and allow you to select keywords and add them to your categories.',
                        // style: onboardingSubtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Image(
                              height: 500,
                              image: AssetImage(
                                  'assets/unkown_words_screenshot.png'))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Report Generation',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'trackefi will then show you the categorisation and give you the ability to\nmove transactions that were wrongly categorised before finally generating the report',
                        // style: onboardingSubtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Image(
                              height: 500,
                              image: AssetImage(
                                  'assets/editable_categoriesed_transactions_screenshot.png'))),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Report',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        'A report can now be generated and broken down for you to analyse',
                        // style: onboardingSubtitleStyle,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Center(
                          child: Image(
                              height: 500,
                              image:
                                  AssetImage('assets/report_screenshot.png'))),
                    ],
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _buildPageIndicator(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _currentPage != 0
                    ? TextButton(
                        onPressed: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.arrow_back,
                              size: 18.0,
                            ),
                            SizedBox(width: 10.0),
                            Text(
                              'Back',
                            ),
                          ],
                        ),
                      )
                    : Container(),
                _currentPage != _numPages - 1
                    ? TextButton(
                        onPressed: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.ease,
                          );
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Text(
                              'Next',
                            ),
                            SizedBox(width: 10.0),
                            Icon(
                              Icons.arrow_forward,
                              size: 18.0,
                            ),
                          ],
                        ),
                      )
                    : TextButton(
                        onPressed: () {
                          _setExistingUser();
                          Navigator.of(context).pop();
                        },
                        child: const Text(
                          'Get started',
                          style: TextStyle(
                            color: TColors.main,
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _setExistingUser() async {
    final setExistingUseCase = await ref.read(setExistingUseCasePovider);
    setExistingUseCase.execute();
  }
}
