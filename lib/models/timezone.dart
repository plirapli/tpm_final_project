class MyTimeZone {
  String name;
  double offset;

  MyTimeZone({required this.name, required this.offset});
}

final List<MyTimeZone> myTimeZones = [
  MyTimeZone(name: 'WIB', offset: 7),
  MyTimeZone(name: 'WITA', offset: 8),
  MyTimeZone(name: 'WIT', offset: 9),
  MyTimeZone(name: 'UTC', offset: 0),
];
