import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
class deatils extends StatefulWidget {
  const deatils({Key? key}) : super(key: key);

  @override
  State<deatils> createState() => _deatilsState();
}

class _deatilsState extends State<deatils> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xffF9F9f9),
     body: Stack (
      children: <Widget> [
        Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomPaint(
            painter: pathPainter(),
          ),
        ),
        Container(
          padding: EdgeInsets.only(left: 20,right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left:14,right: 10,top: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text("Sélectionnez un médecin ou une catégorie",style : TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w700,
                    ),),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: 120,
                      margin: EdgeInsets.only(top: 10),
                      child: ListView(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        children: <Widget>[
                          categoryContainer("category1.png", "Ortho"),
                          categoryContainer("category2.png", "Dietician"),
                          categoryContainer("category3.png", "Physician"),
                          categoryContainer("category4.png", "Paralysis"),
                          categoryContainer("category5.png", "Cardiology"),
                          categoryContainer("category6.png", "MRI - Scan"),
                          categoryContainer("category7.png", "CT-Scan"),
                          categoryContainer("category8.png", "Gyneomcology"),
                        ],
                      ),
                    ),
                    const Text("La liste des Médecins", style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 520,
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Column(
                          children: <Widget>[
                            createDocWidget("doc1.png", "Rachdi Salima","+212 5288-54585","F48G+6P8, Taroudant 83000"),
                            createDocWidget("doc2.png", "Mouniri Mahassine","+212 5288-48497","CC93+85H, Agadir 80000"),
                            createDocWidget("doc2.png", "Benelkadi lahoucine","+212 5288-50485","F4FC+7MR, Taroudant"),
                            createDocWidget("doc1.png", "Tamim Zoubida","+212 5288-22237","Imm GUERMANE, AV 29 Fevrier, Agadir"),
                            createDocWidget("doc2.png", "Bendali Hassan","+212 5283-34093","16 HAGOUNIA AV mokhtar soussi, Inezgane"),
                            createDocWidget("doc2.png", "Jamal Lotf","+212-651-152-123","1er etage n° 87, Imm Albadiaa")
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
  Container categoryContainer(String imgName, String title){
  return Container(
    width: 130,
      child: Column(
        children: <Widget>[
          Image.asset('assets/images/category/$imgName'),
          Text(
            // ignore: unnecessary_string_interpolations, prefer_const_constructors
            "$title", style: TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 17
            ),
          )
        ],
      ),
  );
}
}


Container createDocWidget(String imgName, String docName,String phone, String adresse ){
  return Container(
    child: InkWell(
      // ignore: sort_child_properties_last
      child: Container(
        margin: EdgeInsets.only(bottom: 15) ,
        // ignore: prefer_const_constructors
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          color: Color(0xFF32A060),
        ),
        child: Container(
          padding: EdgeInsets.all(7),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget> [
              Container(
                width: 70,
                height: 90,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/docprofile/$imgName'),
                    fit: BoxFit.cover
                  )
                ),
              ),
              // ignore: prefer_const_constructors
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start ,
                children: <Widget> [
                  // ignore: prefer_const_constructors
                  Text("Dr. $docName",style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white
                  ),),
                  SizedBox(height: 5,),
                  Container(
                    width: 250,
                    height: 50,
                    // ignore: prefer_const_constructors
                    child: Text("Tél : $phone \nAdresse : $adresse",style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white

                    ),
                    overflow: TextOverflow.clip,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
      onTap: openDocInfo,
    ),
  );
}

 void openDocInfo ()
  {
        print("here");

  }  

class pathPainter extends CustomPainter
{
  @override 
  void paint (Canvas canvas,Size size) {
    var paint = new Paint();
    paint.color = Color(0xffcef4e8);

    Path path = new Path();
    path.moveTo(0, 0);
    path.lineTo(size.width*0.3, 0);
    path.quadraticBezierTo(size.width*0.5,size.height*0.03,size.width*0.42,size.height*0.17);
    path.quadraticBezierTo(size.width*0.35,size.height*0.32,0,size.height*0.29);
    path.close();
    canvas.drawPath(path, paint);
  }

  @override 
  bool shouldRepaint (CustomPainter oldDelegate) {
    return true;
  }
}
