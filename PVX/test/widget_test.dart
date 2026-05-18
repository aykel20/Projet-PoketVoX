
import 'package:flutter_test/flutter_test.dart';
import 'package:poketvox/main.dart';
void main(){testWidgets('PoketVoX IA démarre', (tester) async {await tester.pumpWidget(const PoketVoxApp()); expect(find.text('PoketVoX IA'), findsOneWidget);});}
