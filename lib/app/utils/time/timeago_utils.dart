import 'package:timeago/timeago.dart' as timeago;
class TimeAgo {
  static String timeAgo(String time) {
    var parsedDate = DateTime.parse(time);
    var viTimeData = parsedDate.add(Duration(hours: 7));
    timeago.setLocaleMessages('vi', timeago.ViMessages());
    return timeago.format(viTimeData, locale: 'vi');
  }
}

