import 'package:intl/intl.dart';

class Pill {
  final int id;
  final DateTime time;
  final String title;
  final String description;
  final int dosage;
  final int span;
  final int weight;

  const Pill({
    required this.span,
    required this.id,
    required this.weight,
    required this.time,
    required this.title,
    required this.description,
    required this.dosage,
  });

  factory Pill.fromJson(Map<String, dynamic> json) {
    return Pill(
        id: json['id'] as int,
        weight: json['weight'] as int,
        span: json['span'] as int,
        time: json['time'] as DateTime,
        description: json['description'] ?? 'description of a Pill ',
        title: json['title'],
        dosage: json['dosage'] as int);
  }

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'weight': weight,
      'span': span.toString(),
      'time': time.hour,
      'description': 'description',
      'title': title,
      'dosage': dosage
    };
  }

  static String formatTimeOfDay(DateTime tod) {
    final format = DateFormat.yMMMMd().add_Hm() ;  //"6:00 AM"
    print(format.format(tod));
    return format.format(tod);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'time': formatTimeOfDay(time),
      'title': title,
      'description': description,
      'dosage': dosage,
      'span': span,
      'weight': weight,
    };
  }

}
