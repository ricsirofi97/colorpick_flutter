import 'package:hive/hive.dart';
part 'user.g.dart';

@HiveType(typeId: 1)
class User{
  User({
    required this.topScore,
    required this.username,
    required this.darkMode,
    required this.lang
  });

  @HiveField(0)
  int topScore;
  @HiveField(1, defaultValue: "Guest")
  String username;
  @HiveField(2, defaultValue: true)
  bool darkMode;
  @HiveField(3, defaultValue: "en")
  String lang;
}