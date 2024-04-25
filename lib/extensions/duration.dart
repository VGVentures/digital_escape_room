extension DurationX on Duration {
  String toMinuteAndSecond() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final twoDigitMinutes = twoDigits(inMinutes.remainder(60).abs());
    final twoDigitSeconds = twoDigits(inSeconds.remainder(60).abs());
    return '$twoDigitMinutes:$twoDigitSeconds';
  }
}
