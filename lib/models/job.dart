import 'package:minitalk/models/base_enum.dart';

enum Job implements BaseEnum {
  student("대학생"),
  developer("개발자"),
  unemployed("백수");

  @override
  final String value;

  const Job(this.value);
}
