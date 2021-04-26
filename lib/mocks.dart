import 'domain/sight.dart';

final List<Sight> mocks = [
  Sight(
    name: "Свято-Михайловский собор",
    lat: 56.849555,
    lon: 53.205350,
    url: [
      "https://fs.tonkosti.ru/sized/f700x700/c4/7b/c47bld9e0hs08c88s40cck84s.jpg",
      "https://fs.tonkosti.ru/sized/f700x700/c4/7b/c47bld9e0hs08c88s40cck84s.jpg",
      "https://fs.tonkosti.ru/sized/f700x700/c4/7b/c47bld9e0hs08c88s40cck84s.jpg"
    ],
    details: "Свято-Михайловский собор, расположенный в Центральном районе Ижевска, считается визитной карточкой города и символом возрождения духовной жизни Удмуртии и всей России.",
    type: "религия",
    wontDate: DateTime.now(),
  ),
  Sight(
    name: "Ижевский арсенал",
    lat: 56.85347592965163,
    lon: 53.21533958421023,
    url: [
      "https://fs.tonkosti.ru/sized/f700x700/dh/cd/dhcdpt6uwi8848gkk4ok0swcs.jpg",
      "https://fs.tonkosti.ru/sized/f700x700/dh/cd/dhcdpt6uwi8848gkk4ok0swcs.jpg",
      "https://fs.tonkosti.ru/sized/f700x700/dh/cd/dhcdpt6uwi8848gkk4ok0swcs.jpg",
    ],
    details: "Национальный музей Удмуртской Республики имени Кузебая Герда, или ижевский Арсенал, — один из самых больших в Удмуртии музеев с богатой экспозицией. Рядом со зданием бывшего Арсенала находится множество достопримечательностей: мемориал «Вечный огонь», памятник удмуртскому поэту Кузебаю Герду.",
    type: "музей",
    wontDate: DateTime.now(),
  ),
  Sight(
    name: "Ижевский зоопарк",
    lat: 56.86644391935107,
    lon: 53.174246956858354,
    url: [
      "https://fs.tonkosti.ru/sized/f700x700/7g/s7/7gs7uwcyackk0g0kk44w4kogo.jpg",
      "https://fs.tonkosti.ru/sized/f700x700/7g/s7/7gs7uwcyackk0g0kk44w4kogo.jpg",
      "https://fs.tonkosti.ru/sized/f700x700/7g/s7/7gs7uwcyackk0g0kk44w4kogo.jpg",
    ],
    details: "Ижевский зоопарк – одна из главных достопримечательностей столицы Удмуртии. Ижевский зоопарк считается одним из самых крупных и богатых в Приволжье. Общая площадь зоопарка составляет целых 16 гектаров.",
    type: "развлечения",
    visitDate: DateTime.now(),
    wontDate: DateTime.now(),
  ),
];