import 'package:minitalk/models/base_enum.dart';

enum Personality implements BaseEnum {
  extroversion("외향적"),
  introversion("내향적"),
  rational("이성적"),
  emotional("감성적");

  @override
  final String value;

  const Personality(this.value);
}
