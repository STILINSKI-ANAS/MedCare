import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../config/database/sql_helper.dart';
import '../../models/pill.dart';
import '../../router/routes.dart';

class ReminderList extends StatefulWidget {
  final List<Pill> pills;
  final Function callbackFunction;

  const ReminderList({
    Key? key,
    required this.pills,
    required this.callbackFunction,
  }) : super(key: key);

  @override
  State<ReminderList> createState() => _ReminderListState();
}

class _ReminderListState extends State<ReminderList> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Expanded(
        child: SizedBox(
          width: size.width,
          child: ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: (widget.pills != null) ? widget.pills.length : 0,
              itemBuilder: (BuildContext context, int index) {
              Pill pill = widget.pills![index];
              return Column(
                children: [
                  PillCard(
                    callbackFunction: widget.callbackFunction,
                    index: index,
                    pill: pill,
                    onTap: () async {
                      await Navigator.of(context).pushNamed(
                          RouteManager.detailsPage,
                          arguments: {'pill': pill, 'index': index});
                    },
                  ),
                  const SizedBox(height: 8,)
                ],
              );
              }),
    ));
  }
}

class PillCard extends StatelessWidget {
  final Function callbackFunction;

  const PillCard(
      {Key? key,
      required this.pill,
      required this.index,
      this.onTap,
      required this.callbackFunction})
      : super(key: key);

  final Pill pill;
  final int index;
  final VoidCallback? onTap;

  static String formatTimeOfDay(DateTime tod) {
    final dt = DateTime(tod.year, tod.month, tod.day, tod.hour, tod.minute);
    final format = DateFormat.Hm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: (() {
        onTap?.call();
      }),
      child: Container(
          width: size.width-16,
          margin: const EdgeInsets.symmetric(horizontal: 8),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Theme.of(context).colorScheme.secondary)),
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Hero(
                tag: 'image$index',
                child: Image.asset(
                  "assets/images/Pill.png",
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 20,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${pill.title}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '${pill.dosage} comprimé(s)',
                    style: TextStyle(
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(1),
                        fontSize: 14),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        size: 18,
                        color: Theme.of(context)
                            .colorScheme
                            .onPrimary
                            .withOpacity(1),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        formatTimeOfDay(pill.time),
                        style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onPrimary
                                .withOpacity(1)),
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.white,
                    ),
                    width: 50,
                    height: 56,
                    padding: EdgeInsets.only(top: 10, bottom: 5),
                    child: Column(
                      children: [
                        Center(
                            child: Text(
                          '${pill.weight}',
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        )),
                        const Center(
                            child: Text(
                          "mg",
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  )
                ],
              ),
              // const SizedBox(width: 10,),
              Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  iconSize: 40,
                  icon: const Icon(
                    Icons.delete_forever,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    deleteItem(pill);
                    callbackFunction();
                  },
                ),
              ],
            ),
          ])),
    );
  }

  deleteItem(Pill pill) async {
    await SQLhelper.deleteItem(pill);
  }
}