import 'package:intl/intl.dart';

class MethodUtil {
  static String dateConvert(String serverDate) {
    final dateformat = DateFormat('dd-MM-yyyy hh:mm:ss');
    var formattedDate = DateTime.parse(serverDate);
    return dateformat.format(formattedDate);
  }
}
