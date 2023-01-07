// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cells/category_cell.dart';
import '../models/doctor.dart';
import '../models/category.dart';

import '../cells/hd_cell.dart';
import '../cells/trd_cell.dart';
import '../widgets/utils/custom_icons_icons.dart';
import '../widgets/utils/he_color.dart';
import 'detail_page.dart';

class DoctorPage extends StatefulWidget {
  @override
  //_HomePageState createState() => _HomePageState();

  const DoctorPage({Key? key}) : super(key: key);

  @override
  State<DoctorPage> createState() => _DoctorPageState();
}

class _DoctorPageState extends State<DoctorPage> {
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
            SizedBox(
              height: 8,
            ),
            _hDoctorsSection(),
            SizedBox(
              height: 32,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _categorySection(),
                  SizedBox(
                    height: 32,
                  ),
                  _trDoctorsSection(),
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
      title: const Text("La Liste des Medecines"),
      automaticallyImplyLeading: false,
    );
  }

  SizedBox _hDoctorsSection() {
    return SizedBox(
      height: 199,
      child: ListView.separated(
        primary: false,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 24),
        itemCount: _hDoctors.length,
        separatorBuilder: (BuildContext context, int index) =>
            Divider(indent: 16),
        itemBuilder: (BuildContext context, int index) => HDCell(
          doctor: _hDoctors[index],
          onTap: () => _onCellTap(_hDoctors[index]),
        ),
      ),
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
        SizedBox(
          height: 32,
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

  Column _trDoctorsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Docteur hautement qualifié',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w400,
          ),
        ),
        SizedBox(
          height: 32,
        ),
        ListView.separated(
          primary: false,
          shrinkWrap: true,
          itemCount: _trDoctors.length,
          separatorBuilder: (BuildContext context, int index) => Divider(
            thickness: 16,
            color: Colors.transparent,
          ),
          itemBuilder: (BuildContext context, int index) =>
              TrdCell(doctor: _trDoctors[index]),
        ),
      ],
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
      title: 'Cardiologue',
    ));
    categories.add(Category(
      icon: CustomIcons.eyes,
      title: 'Yeux',
    ));
    categories.add(Category(
      icon: CustomIcons.pediatrician,
      title: 'Pédiatre',
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
