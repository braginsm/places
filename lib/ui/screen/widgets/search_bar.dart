import 'package:flutter/material.dart';

class SearchBar  extends StatelessWidget {
  const SearchBar ({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: TextField(),
    );
  }
}