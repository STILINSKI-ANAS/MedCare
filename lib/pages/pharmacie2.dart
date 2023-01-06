import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:iconsax/iconsax.dart';
import 'package:maps_launcher/maps_launcher.dart';

import '../cells/category_cell.dart';
import '../models/doctor.dart';
import '../models/category.dart';

import '../cells/hd_cell.dart';
import '../cells/trd_cell.dart';
import '../widgets/utils/custom_icons_icons.dart';
import '../widgets/utils/he_color.dart';
import 'detail_page.dart';

class PharmacyPage extends StatefulWidget {
  const PharmacyPage({Key? key}) : super(key: key);

  @override
  State<PharmacyPage> createState() => _PharmacyPageState();
}

class _PharmacyPageState extends State<PharmacyPage> {
  List<Doctor> _hDoctors = <Doctor>[];
  List<Category> _categories = <Category>[];
  List<Doctor> _trDoctors = <Doctor>[];

  _onCellTap(Doctor doctor) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => DetailPage(
                key: Key(""),
                doctor: Doctor(
                    firstName: doctor.firstName,
                    image: doctor.image,
                    lastName: doctor.lastName,
                    rating: doctor.rating,
                    type: ''))));
  }

  @override
  void initState() {
    super.initState();
    _hDoctors = _getHDoctors();
    _categories = _getCategories();
    _trDoctors = _getTRDoctors();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _categorySection(),
                  const SizedBox(
                    height: 24,
                  ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      backgroundColor: const Color(0xFF32A060),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      systemOverlayStyle: SystemUiOverlayStyle.light,
      title: const Text("La Liste des Pharmacies de garde"),
      automaticallyImplyLeading: false,
    );
  }

  Column _trDoctorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: _trDoctors.length,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            thickness: 16,
            color: Colors.transparent,
          ),
          itemBuilder: (BuildContext context, int index) =>
              TrdCell(doctor: _trDoctors[index]),
        ),
      ],
    );
  }

  Column _categorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Catégories',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          height: 100,
          child: ListView.separated(
            primary: false,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: _categories.length,
            separatorBuilder: (BuildContext context, int index) =>
                Divider(indent: 16),
            itemBuilder: (BuildContext context, int index) =>
                CategoryCell(category: _categories[index]),
          ),
        ),
      ],
    );
  }

  Container createPharmWidget(String imgName, String pharmName, String pharmphone, String pharmadresse) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            offset: const Offset(0, 3),
            color: HexColor('#404B63').withOpacity(0.1),
            blurRadius: 10,
          ),
        ],
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

  List<Doctor> _getHDoctors() {
    // ignore: deprecated_member_use, prefer_collection_literals
    List<Doctor> hDoctors = <Doctor>[];

    hDoctors.add(Doctor(
      firstName: 'Omare',
      lastName: 'Safroui',
      image: 'albert.png',
      type: 'Néphrologue',
      rating: 4.5,
    ));
    hDoctors.add(Doctor(
      firstName: 'Fatimzhra',
      lastName: 'Moujahid',
      image: 'cherly.png',
      type: 'Néphrologue',
      rating: 4.5,
    ));

    return hDoctors;
  }

  List<Category> _getCategories() {
    List<Category> categories = <Category>[];
    categories.add(Category(
      icon: CustomIcons.cardiologist,
      title: 'Pharmacie de garde',
    ));
    categories.add(Category(
      icon: FluentSystemIcons.ic_fluent_notebook_regular,
      title: 'Pharmacie',
    ));
    categories.add(Category(
      icon: CustomIcons.pediatrician,
      title: 'Parapharmacie',
    ));
    return categories;
  }

  List<Doctor> _getTRDoctors() {
    List<Doctor> trDoctors = <Doctor>[];

    trDoctors.add(Doctor(
      firstName: 'Amine',
      lastName: 'Tazi',
      image: 'mathew.png',
      type: 'Orthopédie',
      rating: 4.3,
    ));
    trDoctors.add(Doctor(
        firstName: 'Morad',
        lastName: 'Elqadmiri',
        image: 'cherly.png',
        type: 'Néphrologue',
        rating: 4.7));
    trDoctors.add(Doctor(
        firstName: 'Marwan',
        lastName: 'Souko',
        image: 'albert.png',
        type: 'Néphrologue',
        rating: 4.3));
    trDoctors.add(Doctor(
      firstName: 'Kawtar',
      lastName: 'Alalali',
      image: 'cherly.png',
      type: 'Néphrologue',
      rating: 4.5,
    ));
    return trDoctors;
  }
}
