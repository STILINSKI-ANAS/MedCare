import 'package:flutter/material.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:url_launcher/url_launcher.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({Key? key}) : super(key: key);

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF9F9f9),
      body: Stack(
        children: <Widget>[
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: CustomPaint(
              painter: pathPainter(),
            ),
          ),
          Container(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 14, right: 10, top: 25),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "La Liste des Pharmacies de garde :",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 620,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child:
                          Column(
                            children: <Widget>[
                              createPharmWidget("lastah.png", "Lastah",
                                  " +212 5288-51685", " F4PG+X7H, Taroudant"),
                              const SizedBox(
                                height: 20,
                              ),
                              createPharmWidget("20aout.png", "20 Aout",
                                  "+212 5288-50363", "F4PG+X7H, Taroudant"),
                              const SizedBox(
                                height: 20,
                              ),
                              createPharmWidget(
                                  "zraib.png",
                                  "Zraib",
                                  "+212 5285-50999",
                                  " 87 Bd Al Ouahda, Taroudant2"),
                              const SizedBox(
                                height: 20,
                              ),
                              createPharmWidget(
                                  "jnanetessrif.png",
                                  "Jnane Tessrif",
                                  "+212 5285-50166",
                                  "F4HM+8HR, Taroudant"),
                              const SizedBox(
                                height: 20,
                              ),
                              createPharmWidget("alnour.png", "Al Nour",
                                  "+212 5288-50700", "Av. Dakhla, Taroudant"),
                              const SizedBox(
                                height: 20,
                              ),
                              createPharmWidget(
                                  "babelkhmiss.png",
                                  "Bab El Khmiss",
                                  "+212 5288-54599",
                                  "Av. Mohammed V, Taroudant")
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}

Container createPharmWidget(String imgName, String pharmName, String pharmphone, String pharmadresse) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      color: Colors.green[100],
      borderRadius: BorderRadius.circular(12),
    ),
    child: Row(
      children: [
      //img
      Container(
        width: 90,
        height: 130,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pharmacie/$imgName'),
                fit: BoxFit.cover),
            borderRadius: const BorderRadius.all(Radius.circular(8.0))),
      ),
      //text
      const SizedBox(
        width: 20,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Pharmacie : $pharmName',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Tél : $pharmphone \nAdresse : $pharmadresse',
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () {
                MapsLauncher.launchQuery('pharmacie $pharmName, Taroudant');
              },
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xFF32A060),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Center(
                  child: Text(
                    'Voir dans la carte',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      )
    ]),
  );
}

class pathPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = const Color(0xffcef4e8);

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(size.width * 0.3, 0);
    path.quadraticBezierTo(size.width * 0.5, size.height * 0.03,
        size.width * 0.42, size.height * 0.17);
    path.quadraticBezierTo(
        size.width * 0.35, size.height * 0.32, 0, size.height * 0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
