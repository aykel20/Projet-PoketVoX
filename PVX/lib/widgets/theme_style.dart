
import 'package:flutter/material.dart';

class ThemeStyle {
  final Color primary; final Color secondary; final Color soft; final String emoji; final List<String> sprites;
  const ThemeStyle(this.primary,this.secondary,this.soft,this.emoji,this.sprites);
}

ThemeStyle styleFor(String theme) {
  switch(theme) {
    case 'Restaurant': return const ThemeStyle(Color(0xFFFF6B6B),Color(0xFFFFC75F),Color(0xFFFFF1D6),'🍽️',['🍕','🍔','🍟','☕','🍣','🥗']);
    case 'Bus': return const ThemeStyle(Color(0xFF0984E3),Color(0xFF74B9FF),Color(0xFFDFF3FF),'🚌',['🚌','🚏','🎫','🚦','🛣️']);
    case 'Magasin': return const ThemeStyle(Color(0xFFE84393),Color(0xFFFF9FF3),Color(0xFFFFE3F4),'🛍️',['🛍️','🛒','🏷️','🎁','💳']);
    case 'Musée': return const ThemeStyle(Color(0xFF6C5CE7),Color(0xFFA29BFE),Color(0xFFEDEAFF),'🏛️',['🏛️','🖼️','🎟️','🏺','📜']);
    case 'Hôtel': return const ThemeStyle(Color(0xFF00B894),Color(0xFF55EFC4),Color(0xFFDDFBF3),'🏨',['🏨','🛏️','🔑','🧳','🛎️']);
    case 'Urgence': return const ThemeStyle(Color(0xFFD63031),Color(0xFFFF7675),Color(0xFFFFE2E2),'🚑',['🚑','🆘','⛑️','➕','📞']);
    default: return const ThemeStyle(Color(0xFF00CEC9),Color(0xFF81ECEC),Color(0xFFE0FFFF),'✈️',['✈️','🚆','🧳','🗺️','🚕']);
  }
}
