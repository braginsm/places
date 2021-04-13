import 'package:flutter/material.dart';
import 'package:places/domain/sight.dart';
import 'package:places/mocks.dart';
import 'package:places/ui/res/text_styles.dart';
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
      body: SingleChildScrollView(
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
                          print(item.name);
                          setState(() {
                            searchHistory.remove(item);
                            searchHistory.insert(0, item);
                          });
                        }),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

class SightSearchState with ChangeNotifier {
  TextEditingController searchBarController = TextEditingController();

  set controller(TextEditingController val) => searchBarController = val;

  List<Sight> _searchResult = mocks;

  void search(String value) {
    print(value);
    _searchResult = value.length > 0
        ? mocks
            .where((element) =>
                element.name.toLowerCase().contains(value.toLowerCase()))
            .toList()
        : [];
    notifyListeners();
  }

  List<Sight> get searchResult => _searchResult;

  void clear() {
    _searchResult.clear();
    notifyListeners();
  }
}
