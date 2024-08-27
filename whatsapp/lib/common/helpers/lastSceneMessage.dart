 String lastSceneMessage(lastScene) {
    DateTime now = DateTime.now();
    Duration differenceDuration =
        now.difference(DateTime.fromMillisecondsSinceEpoch(lastScene));
    String finalMessage = differenceDuration.inSeconds > 59
        ? differenceDuration.inMinutes > 59
            ? differenceDuration.inHours > 23
                ? "${differenceDuration.inDays} ${differenceDuration.inDays == 1 ? 'day' : 'days'}"
                : "${differenceDuration.inHours} ${differenceDuration.inHours == 1 ? 'hour' : 'hours'}"
            : "${differenceDuration.inMinutes} ${differenceDuration.inMinutes == 1 ? 'minute' : 'minutes'}"
        : "${differenceDuration.inSeconds} ${differenceDuration.inSeconds == 1 ? 'second' : 'seconds'}";

    if (differenceDuration.inSeconds == 0) {
      finalMessage = 'a few moments';
    }
    return finalMessage;
  }