import 'package:intl/intl.dart';

String formatDate(String dateStr) {
  try {
    final dateTime = DateTime.parse(dateStr).toLocal();
    final formatter = DateFormat('MMMM d, y \'at\' h:mm a');
    return formatter.format(dateTime);
  } catch (e) {
    return 'Invalid date';
  }
}
