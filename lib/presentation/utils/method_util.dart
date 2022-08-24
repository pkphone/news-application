import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class MethodUtil {
  static String dateConvert(String serverDate) {
    final dateformat = DateFormat('dd-MM-yyyy hh:mm:ss');
    var formattedDate = DateTime.parse(serverDate);
    return dateformat.format(formattedDate);
  }

  static Future<void> launch(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  static String getCurrentDate() {
    var now = DateTime.now();
    var formatter = DateFormat('dd-MM-yyyy');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

  static String linkPreviewBugFix(String link) {
    List<String> paths = link.split('www.');
    if (paths.length > 1) {
      return paths[0] + paths[1];
    } else {
      return paths[0];
    }
  }
}
