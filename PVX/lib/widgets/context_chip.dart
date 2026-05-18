import 'package:flutter/material.dart';
import 'theme_style.dart';

class ContextChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const ContextChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  IconData get icon {
    switch (label) {
      case 'Restaurant':
        return Icons.restaurant;
      case 'Bus':
        return Icons.directions_bus;
      case 'Magasin':
        return Icons.shopping_bag;
      case 'Musée':
        return Icons.museum;
      case 'Hôtel':
        return Icons.hotel;
      case 'Urgence':
        return Icons.health_and_safety;
      default:
        return Icons.flight_takeoff;
    }
  }

  @override
  Widget build(BuildContext context) {
    final style = styleForTheme(label);
    return ChoiceChip(
      selected: selected,
      onSelected: (_) => onTap(),
      avatar: Icon(icon, size: 18, color: selected ? Colors.white : style.primary),
      label: Text(label),
      selectedColor: style.primary,
      backgroundColor: style.accent,
      labelStyle: TextStyle(
        color: selected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w800,
      ),
      side: BorderSide(color: selected ? style.primary : style.secondary.withAlpha(120)),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
    );
  }
}
