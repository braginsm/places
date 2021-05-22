

List<Place> searchHistory = [];

class SerachInteractor {
  Future<List<PlaceDto>> searchPlaces(String name) async {
    return await PlaceDtoRepository().filtered(PlacesFilterRequestDto(
      typeFilter: ['name'],
      nameFilter: name,
    ));
  }
}