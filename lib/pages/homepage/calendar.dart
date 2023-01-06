import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../config/database/sql_helper.dart';

class CalendarDelegate extends StatefulWidget {
  final DateTime date;
  final Function callbackFunction;
  const CalendarDelegate({Key? key, required this.date, required this.callbackFunction}) : super(key: key);

  @override
  State<CalendarDelegate> createState() => _CalendarDelegateState();
}

class _CalendarDelegateState extends State<CalendarDelegate> {
  int _selectedPill = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          border: Border(
            top: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.surface),
            bottom: BorderSide(
                width: 1, color: Theme.of(context).colorScheme.surface),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                RichText(
                  text:  TextSpan(
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.black
                    ),
                    children: <TextSpan>[
                      TextSpan(
                           text: '${DateFormat('MMMM').format(DateTime.now())} ',
                              style: const TextStyle(fontWeight: FontWeight.w500)),
                      TextSpan(
                            text: DateFormat('yyyy').format(DateTime.now()),
                      ),
                    ],
                  ),
                ),
                const Icon(Iconsax.arrow_right_3)
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(children: [
              ...List<Expanded>.generate(7, (index) => Expanded(
                child: DatePill(
                  date: DateTime.utc(
                    DateTime.now().year,
                    DateTime.now().month,
                    DateTime.now().day,
                  ).add(Duration(days: index)),
                  onPressed: () {
                    widget.callbackFunction();
                    setState(() {
                      // print(index);
                      _selectedPill = index;
                    });
                  },
                  active: index == _selectedPill,
                ),
              ))
            ]),
          ],
        ));
  }

}

class DatePill extends StatelessWidget {
  const DatePill(
      {Key? key, this.onPressed, this.active = false, required this.date})
      : super(key: key);
  final VoidCallback? onPressed;
  final DateTime date;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 1),
      child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              onPressed?.call();
              SQLhelper.selectedDate = date;
            },
            child: Container(
              decoration: active
                  ? BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                      color: Theme.of(context).colorScheme.secondary))
                  : null,
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Column(children: [
                Text(DateFormat('d').format(date),
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(active ? 1 : 0.66))),
                Text(
                  DateFormat('EEE').format(date).substring(0, 3).toLowerCase(),
                  style: TextStyle(
                      fontSize: 14,
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(active ? 1 : 0.66)),
                )
              ]),
            ),
          )),
    );
  }
}
