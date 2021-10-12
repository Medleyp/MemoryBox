import 'package:just_audio/just_audio.dart';
import 'package:memory_box/model/user_model.dart';

class AudioService {
  static String _getMinuteDuration(int minutes) {
    String strDuration = minutes.toString() + ' минут';
    if (minutes % 10 == 1) {
      strDuration += 'a';
    } else if (minutes % 10 >= 2 && minutes % 10 <= 4) {
      strDuration += 'ы';
    }
    return strDuration;
  }

  static Future<String> getStrDuratoin(String url) async {
    final player = AudioPlayer();
    int? duration = await getMinutes(url);
    if (duration == null) return '';

    final int minutes = duration;
    final int hours = minutes ~/ 60;
    String strDuration = hours.toString() + ' час';
    if (hours >= 1) {
      if (hours % 10 == 1) {
        strDuration += '';
      } else if (hours % 10 >= 2 && hours % 10 <= 4) {
        strDuration += 'а';
      } else {
        strDuration += 'ов';
      }
      if (minutes > 60) {
        strDuration += _getMinuteDuration(hours * 60 - minutes);
      }
      return strDuration;
    } else {
      return _getMinuteDuration(minutes);
    }
  }

  static Future<int> getMinutes(String url) async {
    final player = AudioPlayer();
    Duration? duration = await player.setUrl(url);
    if (duration != null) return duration.inMinutes;
    return 0;
  }

  static int getIntDuration(List<Map<String, String>> audios) {
    int minutes = 0;
    for (Map<String, String> audio in audios) {
      minutes += int.parse(audio['intDuration']!);
    }
    return minutes;
  }

  static String getHoursEnding(int hours) {
    const String hoursEnding = 'час';

    if (hours % 10 >= 1 && hours % 10 <= 4) {
      return hoursEnding + 'а';
    } else {
      return hoursEnding + 'ов';
    }
  }
}
