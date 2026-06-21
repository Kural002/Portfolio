import 'dart:js' as js;
import 'package:flutter/foundation.dart';

class AudioHelper {
  static bool isSoundEnabled = true;

  static void playClick() {
    if (!isSoundEnabled || !kIsWeb) return;
    try {
      js.context.callMethod('eval', [
        """
        (function() {
          try {
            var AudioContext = window.AudioContext || window.webkitAudioContext;
            if (!AudioContext) return;
            var ctx = new AudioContext();
            var osc = ctx.createOscillator();
            var gain = ctx.createGain();
            
            osc.type = 'sine';
            osc.frequency.setValueAtTime(900, ctx.currentTime);
            osc.frequency.exponentialRampToValueAtTime(150, ctx.currentTime + 0.04);
            
            gain.gain.setValueAtTime(0.015, ctx.currentTime);
            gain.gain.exponentialRampToValueAtTime(0.00001, ctx.currentTime + 0.04);
            
            osc.connect(gain);
            gain.connect(ctx.destination);
            
            osc.start();
            osc.stop(ctx.currentTime + 0.05);
          } catch (e) {}
        })()
        """
      ]);
    } catch (_) {}
  }
}
