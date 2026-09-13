import 'package:flutter/foundation.dart';

class LessonRevealController extends ChangeNotifier {
  LessonRevealController({required this._totalBlocks});

  int _visibleBlocks = 0;
  int _totalBlocks;

  /// Number of blocks currently visible.
  int get visibleBlocks => _visibleBlocks;

  /// Total blocks in this lesson.
  int get totalBlocks => _totalBlocks;

  /// Progress from 0 → 1
  double get progress {
    if (_totalBlocks == 0) return 1;
    return _visibleBlocks / _totalBlocks;
  }

  /// Whether all lesson content has been revealed.
  bool get isCompleted => _visibleBlocks >= _totalBlocks;

  /// Whether more blocks remain.
  bool get hasMore => _visibleBlocks < _totalBlocks;

  /// Reveal one more block.
  bool revealNext() {
    if (!hasMore) return false;

    _visibleBlocks++;

    notifyListeners();
    return true;
  }

  /// Reveal multiple blocks at once.
  bool reveal(int count) {
    if (!hasMore) return false;

    _visibleBlocks += count;

    if (_visibleBlocks > _totalBlocks) {
      _visibleBlocks = _totalBlocks;
    }

    notifyListeners();

    return true;
  }

  /// Instantly reveal everything.
  void revealAll() {
    if (isCompleted) return;

    _visibleBlocks = _totalBlocks;
    notifyListeners();
  }

  /// Reset lesson state.
  void reset() {
    _visibleBlocks = 0;
    notifyListeners();
  }

  /// Used when a different lesson loads.
  void setTotalBlocks(int total) {
    _totalBlocks = total;
    _visibleBlocks = 0;
    notifyListeners();
  }
}
