import 'package:flame/components.dart';
import 'package:flame/palette.dart';

class DebugTextComponent extends TextComponent {
  DebugTextComponent()
      : super('',
            textRenderer: TextPaint(
                config: TextPaintConfig(color: BasicPalette.white.color))) {
    anchor = Anchor.topLeft;
    x = 0;
    y = 16.0;
  }
}
