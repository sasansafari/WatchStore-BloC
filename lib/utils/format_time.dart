String formatTime(int sec) {
  String resultFormat;
  final duration = Duration(seconds: sec);

  int h = duration.inHours;
  int m = duration.inMinutes.remainder(60);
  int s = duration.inSeconds.remainder(60);

  if (sec > 3600) {
    resultFormat = "$h:$m:$s";
  } else {
    resultFormat = "$m:$s";
  }

  return resultFormat;
}
