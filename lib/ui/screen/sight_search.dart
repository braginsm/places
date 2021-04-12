import 'package:flutter/material.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';

class SightSearchScreen extends StatefulWidget {
  SightSearchScreen({Key key}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Список интересных мест"),
            ),
          ],
        ),
        centerTitle: true,
        bottom: PreferredSize(
          child: SearchBar(),
          preferredSize: Size(double.infinity, 64),
        ),
      ),
      body: Text("data"),
    );
  }
}