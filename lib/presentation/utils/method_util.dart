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
}
