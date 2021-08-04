import 'package:flutter/material.dart';

class TabBarWidget extends StatefulWidget {
  final TabController tabController;
  final List<String> tabs;
  TabBarWidget(this.tabController, this.tabs, {Key key}) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
      lowerBound: 0,
      upperBound: widget.tabController.index.toDouble(),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) { 
        return AnimatedBuilder(
          builder: (BuildContext context, Widget child) {
            return Stack(
              children: [
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).backgroundColor,
                    ),
                  ),
                ),
                Positioned(
                  child: Container(
                    height: 40,
                    width: constraints.maxWidth/widget.tabController.length,
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(40),
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),
                Row(
                  children: [
                    for (var text in widget.tabs)
                      Expanded(
                        child: Container(
                          height: 40,
                          child: Center(
                            child: TextButton(
                              onPressed: () {  },
                              child: Text(text),
                            ),
                          ),
                        ),
                      )
                  ],
                )
              ],
            );
          }, animation: _animationController,
        );
      },
    );
  }
}
