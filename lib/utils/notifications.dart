import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:medcare/utils/schedule.dart';

Future<void> createNotification(DateTime time) async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'pill_channel',
      title: "Rappel de pilule",
      body: "Il est temps de prendre votre pilule",
      notificationLayout: NotificationLayout.Default,
    ),
    actionButtons: [
      NotificationActionButton(
        key: 'MARK_DONE',
        label: 'C\'est fait',
      )
    ],
    schedule: NotificationCalendar(
      day: time.day,
      hour: time.hour,
      minute: time.minute,
      second: 0,
      millisecond: 0,
    ),
  );
}
