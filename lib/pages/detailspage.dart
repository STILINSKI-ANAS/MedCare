import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../models/pill.dart';
class DetailsPage extends StatefulWidget {
  const DetailsPage({
    Key? key,
    required this.pill,
    required this.index,
  }) : super(key: key);
  final Pill pill;
  final int index;

  @override
  State<DetailsPage> createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {

  static String formatTimeOfDay(DateTime tod) {
    final dt = DateTime(tod.year, tod.month, tod.day, tod.hour, tod.minute);
    final format = DateFormat.Hm(); //"6:00 AM"
    return format.format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(children: [
        Positioned(
            left: 15,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '',
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 18),
                ),
                const SizedBox(
                  height: 3,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 30,
                  child: Text(
                    "",
                    style: TextStyle(
                        height: 0.95,
                        color: Theme.of(context)
                            .colorScheme
                            .onSurface
                            .withOpacity(0.4),
                        fontWeight: FontWeight.w300,
                        fontSize: 16),
                  ),
                ),
              ],
            )),
        SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.8,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '${widget.pill.title}, 250mg',
                style:
                    const TextStyle(fontWeight: FontWeight.w500, fontSize: 28),
              ),
              Text(
                '${widget.pill.dosage} dose, par Jour',
                style: TextStyle(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.33),
                    fontSize: 20),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.65,
                child: Hero(
                  tag: 'image' + widget.index.toString(),
                  child: Image.asset(
                    "assets/images/PillD.png",
                    fit: BoxFit.cover,
                    filterQuality: FilterQuality.high,
                  ),
                ),
              ),
              Text(
                formatTimeOfDay(widget.pill.time),
                style: const TextStyle(
                  fontSize: 32,
                ),
              )
            ],
          ),
        )
      ]),
    );
  }
  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF32A060),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text("Details Sur Le Medicament"),
    );
  }
}
