import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../cells/detail_cell.dart';
import '../models/doctor.dart';
import '../widgets/utils/custom_icons_icons.dart';
import '../widgets/utils/he_color.dart';

class DetailPage extends StatefulWidget {
  final Doctor doctor;

  const DetailPage({required Key key, required this.doctor}) : super(key: key);

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _titleSection(),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Dr.' +
                        widget.doctor.firstName +
                        ' ' +
                        widget.doctor.lastName,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      Icon(
                        CustomIcons.pin_location,
                        size: 14,
                        color: HexColor('#C6C6CD'),
                      ),
                      SizedBox(
                        width: 4,
                      ),
                      Text(
                        'Agadir, Imm Yassmin NR 16 Etage 2 ',
                        style: TextStyle(
                          color: HexColor('#C6C6CD'),
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    decoration: BoxDecoration(
                      color: HexColor('#FFF9EA'),
                      border: Border.all(color: HexColor('#FFEDBE'), width: 1),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      widget.doctor.type + ' Specialist',
                      style: TextStyle(
                        color: HexColor('#FFBF11'),
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "Dr ${widget.doctor.firstName} "
                    "  ${widget.doctor.lastName} , est un médecin néphrologue qui possède une expertise complète dans les domaines de la néphrologie et de la médecine interne. Alors que le Dr Ho se spécialise dans la dialyse et la néphrologie de soins critiques, des années de formation approfondie lui ont également fourni des compétences pour gérer efficacement une large gamme d'autres maladies rénales, notamment l'altération rénale, l'inflammation, l'infection et la transplantation.",
                    style: TextStyle(
                      color: HexColor('#9E9E9E'),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                    height: 91,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DetailCell(title: '162', subTitle: 'Patients'),
                        DetailCell(title: '4+', subTitle: 'Expérience'),
                        DetailCell(title: '4273', subTitle: 'Notation'),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    "En dehors des conditions liées aux reins, le Dr  offre également des soins et des consultations dans diverses conditions médicales liées à la maladie rénale, comme l'hypertension, le diabète et les maladies vasculaires. ",
                    style: TextStyle(
                      color: HexColor('#9E9E9E'),
                      fontSize: 14,
                      fontWeight: FontWeight.w300,
                    ),
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
      backgroundColor: HexColor('#FF32A060'),
      elevation: 0,
      iconTheme: const IconThemeData(color: Colors.white),
      leading: IconButton(
        icon: const Icon(CustomIcons.arrow_left, size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      systemOverlayStyle: SystemUiOverlayStyle.light,
    );
  }

  Container _titleSection() {
    return Container(
      height: 250,
      color: HexColor('#FF32A060'),
      child: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: SizedBox(
              width: 207,
              height: 178,
              child: Image(
                filterQuality: FilterQuality.high,
                fit: BoxFit.fitHeight,
                image: AssetImage('assets/images/bg_shape.png'),
              ),
            ),
          ),
          Positioned(
            right: 64,
            bottom: 15,
            child: SizedBox(
              height: 250,
              child: AspectRatio(
                aspectRatio: 196 / 285,
                child: Hero(
                  tag: widget.doctor.firstName + widget.doctor.lastName,
                  child: Image(
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.fitHeight,
                    image: AssetImage('assets/images/' + widget.doctor.image),
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              height: 15,
              color: Color(0xFFF6F8FC),
            ),
          ),
          Positioned(
            right: 32,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: HexColor('#FFBB23'),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Text(
                    widget.doctor.rating.toString(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  const Icon(
                    CustomIcons.star,
                    color: Colors.white,
                    size: 14,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
