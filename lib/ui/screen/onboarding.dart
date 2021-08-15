import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_list.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key key}) : super(key: key);

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen>
    with SingleTickerProviderStateMixin {
  int _curentPage = 0;
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
      upperBound: 1,
      lowerBound: .1,
    );
    _animation = Tween<double>(
      begin: 15, end: 104
    ).animate(CurvedAnimation(
      parent: _animationController, 
      curve: Curves.linear,
    ));
    _animationController.forward();
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const int _coutnPage = 3;
    final List<TutorialItem> _tutorialItems = [
      TutorialItem(
        title: "Добро пожаловать в Путеводитель",
        description: "Ищи новые локации и сохраняй самые любимые.",
      ),
      TutorialItem(
        title: "Построй маршрут и отправляйся в путь",
        description: "Достигай цели максимально быстро и комфортно.",
      ),
      TutorialItem(
        title: "Добавляй места, которые нашёл сам",
        description: "Делись самыми интересными и помоги нам стать лучше!",
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const SightListScreen()),
            ),
            child: Text(
              "Пропустить",
              style: TextStyleSet()
                  .textMedium16
                  .copyWith(color: Theme.of(context).accentColor),
            ),
          ),
        ],
      ),
      body: Center(
        child: Stack(
          alignment: AlignmentDirectional.center,
          fit: StackFit.passthrough,
          children: [
            PageView.builder(
              onPageChanged: (value) {
                setState(() {
                  _curentPage = value;
                });
                _animationController.reset();
                _animationController.forward();
              },
              itemCount: _tutorialItems.length,
              itemBuilder: (BuildContext context, int index) {
                final _item = _tutorialItems[index];
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(40),
                      child: AnimatedBuilder(
                        animation: _animationController,
                        builder: (context, child) => Opacity(
                          opacity: _animationController.value,
                          child: SvgPicture.asset(
                            ImagesPaths.tutorial[index],
                            width: _animation.value,
                            height: _animation.value,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(vertical: 8, horizontal: 58),
                      child: Text(
                        _item.title,
                        style: TextStyleSet()
                            .textBold24
                            .copyWith(color: Theme.of(context).primaryColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 58),
                      child: Text(
                        _item.description,
                        style: TextStyleSet()
                            .textRegular
                            .copyWith(color: Theme.of(context).hintColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Container(
                      height: 60,
                    ),
                  ],
                );
              },
            ),
            Positioned(
              bottom: 0,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(24),
                    child: Center(
                      child: Row(
                        children: [
                          for (var i = 0; i < _coutnPage; i++)
                            Container(
                              width: _curentPage == i ? 24 : 8,
                              height: 8,
                              margin: const EdgeInsets.all(4),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: _curentPage == i
                                    ? Theme.of(context).accentColor
                                    : Theme.of(context).unselectedWidgetColor,
                              ),
                            )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 64,
                    padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: (_tutorialItems.length == _curentPage + 1)
                        ? ElevatedButton(
                            onPressed: () => Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (contex) => const SightListScreen(),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Text(
                                "НА СТАРТ",
                                style: TextStyleSet().textBold.copyWith(
                                    color: Theme.of(context).canvasColor),
                              ),
                            ),
                          )
                        : const SizedBox.shrink(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TutorialItem {
  String title = "";
  String description = "";
  TutorialItem({this.title, this.description});
}
