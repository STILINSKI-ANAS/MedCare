import 'package:flutter/material.dart';
import 'package:medcare/router/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GetStartBtn extends StatelessWidget {
  const GetStartBtn({
    Key? key,
    required this.size,
    required this.textTheme,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).pushNamed(
            RouteManager.bottomBar);
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('showHome', true);
      },
      child: Container(
        margin: const EdgeInsets.only(top: 60),
        width: size.width / 1.5,
        height: size.height / 13,
        decoration: BoxDecoration(
            color: Color(0xFF32A060), borderRadius: BorderRadius.circular(15)),
        child: Center(
          child: Text("Commencez maintenant", style: textTheme.headline4),
        ),
      ),
    );
  }
}

class SkipBtn extends StatelessWidget {
  const SkipBtn({
    Key? key,
    required this.size,
    required this.textTheme,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final TextTheme textTheme;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 60),
      width: size.width / 1.5,
      height: size.height / 13,
      decoration: BoxDecoration(
          border: Border.all(
            color:  Color(0xFF32A060),
            width: 2,
          ),
          borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12.0),
        onTap: onTap,
        splashColor: Color(0xFF32A060),
        child: Center(
          child: Text("Passer", style: textTheme.headline3),
        ),
      ),
    );
  }
}
