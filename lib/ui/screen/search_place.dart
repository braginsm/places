import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:places/data/blocks/search_place/search_place_bloc.dart';
import 'package:places/data/blocks/search_place/search_place_event.dart';
import 'package:places/data/blocks/search_place/search_place_state.dart';
import 'package:places/data/interactor/search_interactor.dart';
import 'package:places/data/model/place_dto.dart';
import 'package:places/ui/res/images.dart';
import 'package:places/ui/res/text_styles.dart';
import 'package:places/ui/screen/widgets/bottom_navigation.dart';
import 'package:places/ui/screen/widgets/delimer.dart';
import 'package:places/ui/screen/widgets/search_bar.dart';
import 'package:provider/provider.dart';

import 'place_card.dart';
import 'widgets/preloader.dart';

class SearchPlaceScreen extends StatefulWidget {
  const SearchPlaceScreen({Key? key}) : super(key: key);

  @override
  _SearchPlaceScreenState createState() => _SearchPlaceScreenState();
}

class _SearchPlaceScreenState extends State<SearchPlaceScreen> {
  TextEditingController searchController = TextEditingController();

  late SearchPlaceBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = SearchPlaceBloc(context.read<SerachInteractor>())
      ..add(const SearchPlacePrintQueryEvent(""));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bloc,
      child: Scaffold(
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
            children: const [
              Padding(
                padding: EdgeInsets.all(16),
                child: Text("Список интересных мест"),
              ),
            ],
          ),
          centerTitle: true,
          bottom: PreferredSize(
            child: SearchBar(controller: searchController),
            preferredSize: const Size(double.infinity, 64),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (searchHistory.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ВЫ ИСКАЛИ",
                      style: TextStyleSet().textRegular.copyWith(
                          color: Theme.of(context).unselectedWidgetColor),
                    ),
                    SizedBox(
                      height: 64.0 * searchHistory.length,
                      child: ListView.builder(
                        itemCount: searchHistory.length,
                        itemBuilder: (context, index) {
                          final item = searchHistory[index];
                          return Column(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8),
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
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                      ),
                                      IconButton(
                                        icon: Icon(
                                          Icons.close,
                                          color: Theme.of(context).hintColor,
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
                                const Delimer(),
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
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 8),
                      ),
                    ),
                  ],
                ),
              ),
            BlocBuilder(builder: (context, dynamic state) {
              if (state is SearchPlaceLoadingInProgressState) {
                return const Center(
                  child: PreloaderWidget(),
                );
              }
              if (state is SearchPlaceLoadingSuccessState) {
                final placeList = state.result as List<PlaceDto>;
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
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PlaceCardScreen(item.id),
                            ),
                          );
                        },
                      );
                    },
                  ),
                );
              }
              if (state is SearchPlaceEmptyState) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    //crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(32),
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
                        padding: const EdgeInsets.all(8),
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
              throw ArgumentError(
                  "Не предусмотренное состояние в SearchPlaceScreen");
            }),
          ],
        ),
        bottomNavigationBar: const BottomNavigation(),
      ),
    );
  }
}
