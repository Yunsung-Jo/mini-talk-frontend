import 'package:flutter/material.dart';

abstract class BaseView extends StatelessWidget {
  final String label;
  final String icon;
  final int index;

  const BaseView({
    super.key,
    required this.label,
    required this.icon,
    required this.index,
  });
}
