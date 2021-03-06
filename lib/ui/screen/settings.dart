import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:places/data/interactor/user_property_interactor.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/delimer.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:provider/provider.dart';

import '../../app.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _dark =context.read<MainState>().isDark;

  Future<void> _onToggle(bool value) async {
    await context.read<UserPropertyInteractor>().setDarkTheme(value);
    setState(() {
      _dark = value;
    });
    context.read<MainState>().changeTheme(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(16),
          child: Text("Натройки"),
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
                    onToggle: _onToggle,
                    value: _dark,
                    inactiveColor: Theme.of(context).unselectedWidgetColor,
                    activeColor: Theme.of(context).colorScheme.secondary,
                    toggleSize: 28,
                    toggleColor: Theme.of(context).scaffoldBackgroundColor,
                  ),
                ),
              ],
            ),
            const Delimer(),
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
                    // ignore: avoid_print
                    print('Смотреть туториал');
                  },
                )
              ],
            ),
            const Delimer(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
