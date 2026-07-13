import 'dart:math';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    GameWidget(
      game: MasterclassTechHUDGame(),
    ),
  );
}

class MasterclassTechHUDGame extends FlameGame with DragCallbacks {
  Vector2 pointerPosition = Vector2.zero();
  Vector2 targetPosition = Vector2.zero();
  double pointerVelocity = 0.0;
  bool isInteracting = false;
  double runtime = 0.0;
  
  final List<double> velocityHistory = List.generate(40, (_) => 0.0);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    pointerPosition = size / 2;
    targetPosition = size / 2;

    add(DotMatrixBackground());
    add(LiveOscilloscopePanel());
    add(TacticalDiagnosticsPanel());
    add(VectorTargetingReticle());
  }

  @override
  void onDragUpdate(DragUpdateEvent event) {
    isInteracting = true;
    targetPosition = event.localEndPosition;
    pointerVelocity = event.delta.length;
  }

  @override
  void onDragEnd(DragEndEvent event) {
    isInteracting = false;
  }

  @override
  void update(double dt) {
    super.update(dt);
    runtime += dt;

    pointerPosition.lerp(targetPosition, 0.12);

    if (!isInteracting) {
      pointerVelocity = (pointerVelocity - (dt * 150)).clamp(0.0, 500.0);
    }

    if (runtime % 0.04 < dt) {
      velocityHistory.removeAt(0);
      velocityHistory.add(pointerVelocity);
    }
  }
}

class DotMatrixBackground extends Component with HasGameReference<MasterclassTechHUDGame> {
  @override
  void render(Canvas canvas) {
    final size = game.size;
    
    canvas.drawRect(Offset.zero & Size(size.x, size.y), Paint()..color = const Color(0xFF05070B));

    final tickPaint = Paint()
      ..color = const Color(0xFF161C26)
      ..strokeWidth = 1.0;

    const double spacing = 60.0;
    for (double x = spacing; x < size.x; x += spacing) {
      for (double y = spacing; y < size.y; y += spacing) {
        canvas.drawLine(Offset(x - 4, y), Offset(x + 4, y), tickPaint);
        canvas.drawLine(Offset(x, y - 4), Offset(x, y + 4), tickPaint);
      }
    }
  }
}

class VectorTargetingReticle extends Component with HasGameReference<MasterclassTechHUDGame> {
  @override
  void render(Canvas canvas) {
    final cursor = game.pointerPosition;
    final size = game.size;

    final axisPaint = Paint()
      ..color = const Color(0xFF00E5FF).withOpacity(0.08)
      ..strokeWidth = 0.8;
    canvas.drawLine(Offset(0, cursor.y), Offset(size.x, cursor.y), axisPaint);
    canvas.drawLine(Offset(cursor.x, 0), Offset(cursor.x, size.y), axisPaint);

    canvas.save();
    canvas.translate(cursor.x, cursor.y);
    
    canvas.rotate(game.runtime * 0.5);

    final hudOrange = const Color(0xFFFF6D00);
    final reticlePaint = Paint()
      ..color = game.isInteracting ? hudOrange : const Color(0xFF00E5FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    canvas.drawCircle(Offset.zero, 8, reticlePaint..style = PaintingStyle.fill);
    canvas.drawCircle(Offset.zero, 24, reticlePaint..style = PaintingStyle.stroke);

    const double bSize = 36.0;
    const double gap = 8.0;
    
    canvas.drawLine(const Offset(-bSize, -bSize + gap), const Offset(-bSize, -bSize), reticlePaint);
    canvas.drawLine(const Offset(-bSize, -bSize), const Offset(-bSize + gap, -bSize), reticlePaint);
    canvas.drawLine(const Offset(bSize, -bSize + gap), const Offset(bSize, -bSize), reticlePaint);
    canvas.drawLine(const Offset(bSize, -bSize), const Offset(bSize - gap, -bSize), reticlePaint);
    canvas.drawLine(const Offset(-bSize, bSize - gap), const Offset(-bSize, bSize), reticlePaint);
    canvas.drawLine(const Offset(-bSize, bSize), const Offset(-bSize + gap, bSize), reticlePaint);
    canvas.drawLine(const Offset(bSize, bSize - gap), const Offset(bSize, bSize), reticlePaint);
    canvas.drawLine(const Offset(bSize, bSize), const Offset(bSize - gap, bSize), reticlePaint);

    canvas.restore();
  }
}

class TacticalDiagnosticsPanel extends PositionComponent with HasGameReference<MasterclassTechHUDGame> {
  late TextPainter _tp;

  @override
  Future<void> onLoad() async {
    size = Vector2(300, 180);
    position = Vector2(25, 25);
    _tp = TextPainter(textDirection: TextDirection.ltr);
  }

  @override
  void render(Canvas canvas) {
    final rect = Offset.zero & Size(size.x, size.y);
    
    canvas.drawRect(rect, Paint()..color = const Color(0xDC0A0E17));
    canvas.drawRect(rect, Paint()..color = const Color(0xFF1D2736).withOpacity(0.15)..style = PaintingStyle.stroke);

    final framePaint = Paint()..color = const Color(0xFFFF6D00)..strokeWidth = 3.5;
    canvas.drawLine(Offset.zero, const Offset(0, 30), framePaint);
    canvas.drawLine(Offset.zero, const Offset(40, 0), framePaint..strokeWidth = 1.0);

    _drawText(canvas, "◆ TELEMETRY SYSTEM ENGAGED", 14, 11, const Color(0xFFFF6D00), isBold: true);
    _drawText(canvas, "LINK MODE // VECTOR INPUT CONTEXT", 40, 10, Colors.white60);
    _drawText(canvas, "X-COORD : ${game.pointerPosition.x.toStringAsFixed(2)} px", 64, 10, const Color(0xFF00E5FF));
    _drawText(canvas, "Y-COORD : ${game.pointerPosition.y.toStringAsFixed(2)} px", 80, 10, const Color(0xFF00E5FF));
    
    String statusStr = game.isInteracting ? "ACQUIRING TARGET DATA" : "SYSTEM IDLE // SCANNING";
    Color statusColor = game.isInteracting ? const Color(0xFFFF3D00) : const Color(0xFF00E5FF);
    _drawText(canvas, "ALRTLOG : $statusStr", 112, 10, statusColor);

    for (int i = 0; i < 8; i++) {
      final blockPaint = Paint()
        ..color = (game.isInteracting && i > 4) ? const Color(0xFFFF6D00) : const Color(0xFF00E5FF).withOpacity(i * 0.1 + 0.2);
      canvas.drawRect(Rect.fromLTWH(16.0 + (i * 12), 142, 8, 10), blockPaint);
    }
    _drawText(canvas, "SIGNAL INDEX ARRAY", 158, 8, Colors.white38);
  }

  void _drawText(Canvas canvas, String msg, double y, double fSize, Color color, {bool isBold = false}) {
    _tp.text = TextSpan(
      text: msg,
      style: TextStyle(
        color: color,
        fontSize: fSize,
        fontFamily: 'monospace',
        fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
        letterSpacing: 1.3,
      ),
    );
    _tp.layout();
    _tp.paint(canvas, Offset(16, y));
  }
}

class LiveOscilloscopePanel extends PositionComponent with HasGameReference<MasterclassTechHUDGame> {
  late TextPainter _graphLabel;

  @override
  Future<void> onLoad() async {
    size = Vector2(340, 110);
    _graphLabel = TextPainter(textDirection: TextDirection.ltr);
  }

  @override
  void render(Canvas canvas) {
    position = Vector2(game.size.x - size.x - 25, game.size.y - size.y - 25);

    final rect = Offset.zero & Size(size.x, size.y);
    canvas.drawRect(rect, Paint()..color = const Color(0xDC0A0E17));
    canvas.drawRect(rect, Paint()..color = const Color(0xFF1D2736)..style = PaintingStyle.stroke);

    final refPaint = Paint()..color = const Color(0xFF161F2E)..strokeWidth = 0.5;
    canvas.drawLine(Offset(0, size.y / 2), Offset(size.x, size.y / 2), refPaint);
    canvas.drawLine(Offset(size.x / 2, 0), Offset(size.x / 2, size.y), refPaint);

    final path = Path();
    double stepX = size.x / (game.velocityHistory.length - 1);

    for (int i = 0; i < game.velocityHistory.length; i++) {
      double normalVal = (game.velocityHistory[i] / 350.0).clamp(0.0, 1.0);
      double graphY = size.y - 12 - (normalVal * (size.y - 24));
      double graphX = i * stepX;

      if (i == 0) {
        path.moveTo(graphX, graphY);
      } else {
        path.lineTo(graphX, graphY);
      }
    }

    final wavePaint = Paint()
      ..color = const Color(0xFF00E5FF)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawPath(path, wavePaint);

    _graphLabel.text = const TextSpan(
      text: "LIVE KINETIC DATA OSCILLOSCOPE (Hz)",
      style: TextStyle(color: Color(0xFFFF6D00), fontSize: 9, fontFamily: 'monospace', letterSpacing: 1.1),
    );
    _graphLabel.layout();
    _graphLabel.paint(canvas, const Offset(12, 10));
  }
}
