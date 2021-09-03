import 'package:hive/hive.dart';

part 'log.g.dart';

// to re-generate
// flutter packages pub run build_runner build

@HiveType(typeId: 0)
class Log {
  @HiveField(0)
  late String name;

  @HiveField(1)
  late double hours;

  @HiveField(2)
  late Map<DateTime, String> dateLog;

  Log({
    required this.name,
    required this.hours,
    required this.dateLog,
  });
}
