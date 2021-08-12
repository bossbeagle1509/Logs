import 'package:hive/hive.dart';

part 'log.g.dart';

@HiveType(typeId: 0)
class Log {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double hours;

  Log({
    required this.name,
    required this.hours
  });
}
