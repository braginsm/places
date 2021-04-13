import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/sight_card.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:places/ui/screen/widgets/delimer.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:provider/provider.dart';

class SightSearchScreen extends StatefulWidget {
  SightSearchScreen({Key key}) : super(key: key);

  @override
  _SightSearchScreenState createState() => _SightSearchScreenState();
}

class _SightSearchScreenState extends State<SightSearchScreen> {
  List<Sight> searchHistory = [];
  List<Sight> searchResult = [];

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    searchHistory = [];
    searchResult = [];
    context.read<SightSearchState>().controller = searchController;
  }

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
          child: SearchBar(controller: searchController),
          preferredSize: Size(double.infinity, 64),
        ),
      ),
      body: (searchHistory.length == 0 && context.watch<SightSearchState>().searchResult.length == 0) ? 
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(32),
                child: SvgPicture.asset(
                  ImagesPaths.search,
                  height: 50,
                  width: 50,
                ),
              ),
              Text(
                "Ничего не найдено.",
                style: TextStyleSet().textMedium18.copyWith(
                  color: Theme.of(context).unselectedWidgetColor
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8),
                child: Text(
                  "Попробуйте изменить параметры поиска",
                style: TextStyleSet().textRegular.copyWith(
                  color: Theme.of(context).unselectedWidgetColor
                ),
                ),
              ),
            ],
          ),
        ) : SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (searchHistory.length > 0)
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ВЫ ИСКАЛИ",
                      style: TextStyleSet().textRegular.copyWith(
                          color: Theme.of(context).unselectedWidgetColor),
                    ),
                    for (var i = 0; i < searchHistory.length; i++)
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  searchHistory[i].name,
                                  style: TextStyleSet().textRegular16.copyWith(
                                        color: Theme.of(context).hintColor,
                                      ),
                                ),
                                IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Theme.of(context).hintColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      searchHistory.removeAt(i);
                                    });
                                  },
                                )
                              ],
                            ),
                          ),
                          if (i < searchHistory.length - 1) Delimer(),
                        ],
                      ),
                    TextButton(
                      onPressed: () {
                        setState(() {
                          searchHistory.clear();
                          searchController.clear();
                        });
                      },
                      child: Text(
                        "Очистить историю",
                        style: TextStyleSet().textMedium16.copyWith(
                              color: Theme.of(context).accentColor,
                            ),
                      ),
                      style: TextButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            if (context.watch<SightSearchState>().searchResult.length > 0)
              Column(
                children: [
                  for (var item
                      in context.watch<SightSearchState>().searchResult)
                    ListTile(
                        leading: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: Image.network(item.url).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: TextStyleSet().textMedium16,
                        ),
                        subtitle: Text(
                          item.type,
                          style: TextStyleSet().textRegular.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                        onTap: () {
                          setState(() {
                            searchHistory.remove(item);
                            searchHistory.insert(0, item);
                          });
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SightCard(item)));
                        }),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

class SightSearchState with ChangeNotifier {
  TextEditingController searchBarController = TextEditingController();

  set controller(TextEditingController val) => searchBarController = val;

  List<Sight> _searchResult = mocks;

  void search(String value) {
    _searchResult = value.length > 0
        ? mocks
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()) &&
                _inDistans(element))
            .toList()
        : [];
    notifyListeners();
  }

  void filterByRadius() {
    _searchResult = mocks.where((f) => _inDistans(f)).toList();
    notifyListeners();
  }

  List<Sight> get searchResult => _searchResult;

  void clear() {
    _searchResult.clear();
    notifyListeners();
  }

  RangeValues _radius = RangeValues(100, 10000);

  RangeValues get radius => _radius;

  void radiusSet(RangeValues radius) {
    _radius = radius;
    notifyListeners();
  }

  /// хранение значений фильтров
  List<bool> _filterValues = List.generate(6, (index) => false);

  List<bool> get filterValues => _filterValues;

  void changeFilter(int i) {
    _filterValues[i] = !_filterValues[i];
    notifyListeners();
  }

  void cleanFilter() {
    _filterValues = List.generate(6, (index) => false);
    notifyListeners();
  }

  /// текущие координаты 56.84987946580704, 53.247889685270756
  final double lat = 56.84987946580704;
  final double lon = 53.247889685270756;

  ///Определяет, попадает ли достопримечательность в выбанный радиус
  bool _inDistans(Sight sight) {
    final double _distans = sight.getDistans(lat, lon);
    return _radius.start <= _distans && _radius.end >= _distans;
  }
}
