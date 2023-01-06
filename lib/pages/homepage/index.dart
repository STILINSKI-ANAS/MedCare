import 'package:flutter/material.dart';
import 'package:medcare/pages/homepage/reminderlist.dart';
import '../../config/database/sql_helper.dart';
import '../../models/pill.dart';
import 'calendar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    refreshJournals();
  }
  List<Pill> _pills = [];

  void refreshJournals() async {
    var data = await SQLhelper.getItems();
    List<Pill> _pillsloc = [];
    setState(() {
      for(int i=0;i<data.length;i++){
        if(SQLhelper.selectedDate.day >= data[i].time.day && SQLhelper.selectedDate.day <= data[i].time.day+data[i].span-1){
          _pillsloc.add(data[i]);
        }
      }
      _pills = _pillsloc;
    });
  }

  callback(){
    setState(() {
      refreshJournals();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            const TopBar(),
            CalendarDelegate(date: SQLhelper.selectedDate, callbackFunction: callback),
            ReminderList(pills: _pills,callbackFunction: callback)
          ],
        ),
      ),
    );
  }

}

class TopBar extends StatelessWidget {
  const TopBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: 150,
      child: Stack(fit: StackFit.expand, children: [
        Image.asset(
          "assets/images/Background.png",
          fit: BoxFit.cover,
        ),
        Positioned(
           bottom: 30,
            left: MediaQuery.of(context).size.width / 2 - 100,
            right: MediaQuery.of(context).size.width / 2 - 100,
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                style: TextStyle(
                  fontSize: 32,
                ),
                children: <TextSpan>[
                  TextSpan(
                      text: 'Rappel de  ',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  TextSpan(
                      text: 'Médicament',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ],
              ),
            )),
      ]),
    );
  }
}

