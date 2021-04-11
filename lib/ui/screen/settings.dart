import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/widget/bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../../main.dart';

class SettingsScreen extends StatefulWidget {
  SettingsScreen({Key key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            "Натройки",
            style: TextStyleSet()
                .textMedium18
                .copyWith(color: Theme.of(context).primaryColor),
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Тёмная тема',
                  style: TextStyleSet()
                      .textRegular16
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: FlutterSwitch(
                    onToggle: (bool value) => context.read<MainState>().changeTheme(), 
                    value: context.watch<MainState>().isDark,
                    inactiveColor: Theme.of(context).unselectedWidgetColor,
                    activeColor: Theme.of(context).accentColor,
                    toggleSize: 28,
                    toggleColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
            Container(
              height: 0.8,
              width: double.infinity,
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.056),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Смотреть туториал',
                  style: TextStyleSet()
                      .textRegular16
                      .copyWith(color: Theme.of(context).primaryColor),
                ),
                IconButton(
                  icon: SvgPicture.asset(ImagesPaths.info),
                  onPressed: () {
                    print('Смотреть туториал');
                  },
                )
              ],
            ),
            Container(
              height: 0.8,
              width: double.infinity,
              color: Theme.of(context).unselectedWidgetColor.withOpacity(0.056),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
