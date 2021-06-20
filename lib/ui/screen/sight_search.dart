import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/interactor/SearchInteractor.dart';
import 'package:places/data/model/Place.dart';
import 'package:places/data/model/PlaceDto.dart';
import 'package:places/data/redux/action/search_action.dart';
import 'package:places/data/redux/state/app_state.dart';
import 'package:places/data/redux/state/search_state.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
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
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //context.read<SightSearchState>().controller = searchController;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Theme.of(context).primaryColor,
            size: 15,
          ),
          onPressed: () => Navigator.pop(context),
        ),
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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (searchHistory.isNotEmpty)
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
                  Container(
                    height: 64.0 * searchHistory.length,
                    child: ListView.builder(
                      itemCount: searchHistory.length,
                      itemBuilder: (context, index) {
                        final item = searchHistory[index];
                        return Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: InkWell(
                                onTap: () {
                                  searchController.text = item.name;
                                },
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      item.name,
                                      style: TextStyleSet()
                                          .textRegular16
                                          .copyWith(
                                            color: Theme.of(context)
                                                .hintColor,
                                          ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.close,
                                        color:
                                            Theme.of(context).hintColor,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          searchHistory.removeAt(index);
                                        });
                                      },
                                    )
                                  ],
                                ),
                              ),
                            ),
                            if (index < searchHistory.length - 1)
                              Delimer(),
                          ],
                        );
                      },
                    ),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 0, vertical: 8),
                    ),
                  ),
                ],
              ),
            ),
          StoreConnector<AppState, SearchState>(
            onInit: (store) {
              store.dispatch(InitSearch());
            },
            converter: (store) {
              return store.state.searchState;
            },
            builder: (BuildContext context, SearchState state) {
              if (state is SearchInitialState) {
                return Center(
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
                            color: Theme.of(context).unselectedWidgetColor),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8),
                        child: Text(
                          "Попробуйте изменить параметры поиска",
                          style: TextStyleSet().textRegular.copyWith(
                              color: Theme.of(context).unselectedWidgetColor),
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (state is SearchLoadingState) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is SearchDataState) {
                final placeList = state.placeLIst;
                return Flexible(
                  child: ListView.builder(
                    itemCount: placeList.length,
                    itemBuilder: (context, index) {
                      final item = placeList[index];
                      return ListTile(
                        leading: Container(
                          width: 56,
                          height: 56,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: Image.network(item.urls.first).image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        title: Text(
                          item.name,
                          style: TextStyleSet().textMedium16,
                        ),
                        subtitle: Text(
                          item.placeTypeName,
                          style: TextStyleSet().textRegular.copyWith(
                                color: Theme.of(context).hintColor,
                              ),
                        ),
                        onTap: () {
                          setState(() {
                            searchHistory.remove(item);
                            searchHistory.insert(0, item);
                          });
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => SightCard(item)));
                        },
                      );
                    },
                  ),
                );
              }
              throw ArgumentError("Непредусмотренный state в SearchState");
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}

/*class SightSearchState with ChangeNotifier {
  TextEditingController searchBarController = TextEditingController();

  set controller(TextEditingController val) => searchBarController = val;

  List<PlaceDto> _searchResult = searchHistory;

  bool showPreloader = false;

  void search(String value) async {
    showPreloader = true;
    if (value.length > 0) {
      _searchResult = await SerachInteractor().searchPlacesByName(value/*, radius: _radius.end*/);
    } else {
      _searchResult = [];
    }
    showPreloader = false;
    notifyListeners();
  }

  void filterByRadius() {
    _searchResult = _searchResult.where((f) => _inDistans(f)).toList();
    notifyListeners();
  }

  List<PlaceDto> get searchResult => _searchResult;

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
  List<bool> _filterValues = List.generate(PlaceType.other.index, (index) => false);

  bool filterValue(String name) => _filterValues[_titles.indexOf(name)];

  /// подписи фильтров
  final List<String> _titles = Place.ruPlaceTypeNames;

  List<String> get titles => _titles;

  void changeFilter(String name) {
    final index = _titles.indexOf(name);
    _filterValues[index] = !_filterValues[index];
    notifyListeners();
  }

  void cleanFilter() {
    _filterValues = List.generate(6, (index) => false);
    notifyListeners();
  }

  ///Определяет, попадает ли достопримечательность в выбанный радиус
  bool _inDistans(PlaceDto place) {
    return _radius.start <= place.distance && _radius.end >= place.distance;
  }
}*/
