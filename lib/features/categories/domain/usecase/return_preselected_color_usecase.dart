import 'package:Trackefi/features/categories/domain/model/category.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final returnPreselectedColorUseCase = Provider<ReturnPreselectedColorUseCase>(
    (ref) => ReturnPreselectedColorUseCase());

class ReturnPreselectedColorUseCase {
  ReturnPreselectedColorUseCase();

  ColorValues execute(int numberOfCategories) {
    final index = numberOfCategories < colors.length
        ? numberOfCategories
        : numberOfCategories - colors.length;
    return ColorValues.fromColor(colors[index]);
  }

  final List<Color> colors = const [
    Color(0xFFB80C09),
    // real pallet
    Color(0xFFF94144),
    Color(0xFFF3722C),
    Color(0xFFF8961E),
    Color(0xFFF9844A),
    Color(0xFFF9C74F),
    Color(0xFF90BE6D),
    Color(0xFF43AA8B),
    Color(0xFF4D908E),
    Color(0xFF577590),
    Color(0xFF277DA1),
    // Custom additions out of pallet
    Color(0xFF0B6E4F),
    Color(0xFF224870),
    Color(0xFF18324E),
    Color(0xFF870058),
  ];
}
