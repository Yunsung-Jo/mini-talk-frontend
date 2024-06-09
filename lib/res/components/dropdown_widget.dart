import 'package:flutter/material.dart';
import 'package:minitalk/models/base_enum.dart';
import 'package:minitalk/res/colors.dart';
import 'package:minitalk/res/style/decoration_style.dart';

class DropdownWidget<T> extends StatelessWidget {
  final T? value;
  final List<T> items;
  final Function(T) onChanged;

  const DropdownWidget({
    super.key,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return InputDecorator(
      decoration: AppDecorationStyle.instance.lightGray.applyDefaults(const InputDecorationTheme(
        contentPadding: EdgeInsets.fromLTRB(16, 8, 8, 8),
      )),
      child: DropdownButtonHideUnderline(
        child: DropdownButton(
          value: value,
          items: items.map((value) {
            return DropdownMenuItem(
              value: value,
              child: Text((value as BaseEnum).value),
            );
          }).toList(),
          onChanged: (value) {
            onChanged.call(value! as T);
          },
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            size: 30,
            color: AppColors.primary,
          ),
          isExpanded: true,
        ),
      ),
    );
  }
}
