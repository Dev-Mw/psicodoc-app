
import 'package:flutter/material.dart';
import 'package:psicodoc/question_daily.dart';
import 'package:psicodoc/service/config.dart';
import 'package:psicodoc/service/start_weekly_service.dart';


class StartWeeklyPage extends StatelessWidget {

  void next_page(BuildContext ctx, String feeling) {

    try {
      prefs.then((pref) {
        var email = pref.getString("email").toString();
        var username = pref.getString("username").toString();

        Future<Map<String, dynamic>> body = start_weekly_service(email, username, feeling);
        body.then((body) {
          if(body["data"] == "ok"){
            print("hola");

            final now = DateTime.now();

            pref.setString("date_feeling", "${now.year}-${now.month}-${now.day}");
            print("yolo");
            final route = MaterialPageRoute(builder: (context) => QuestionDailyPage());
            Navigator.push(ctx, route);

          }
        });
      });
    }
    catch(e) {

    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ctx = context;
    final name = "Dario";

    return Scaffold(
        body: Column(
          children: [
            const Padding(padding: const EdgeInsets.only(top: 100, bottom: 20), child: Text('¿Cómo te sientes hoy?',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30), textAlign: TextAlign.center,),),


            const Expanded(child: Text(''),),

            Padding(padding: EdgeInsets.only(left: 20, right: 20), child:
            Container(

              height: 100,
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [


                  // horrible
                  Container(
                    child: TextButton(child: Column(
                      children: [
                        Image.asset('assets/img/emoji/llanto.png', width:size.width/10),
                        SizedBox(height: 10,),
                        const Text('horrible', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),)
                      ],
                    ), onPressed: () => next_page(ctx, 'horrible'))
                  ),


                  // mal
                  Container(
                      child: TextButton(child: Column(
                        children: [
                          Image.asset('assets/img/emoji/triste.png', width:size.width/10),
                          SizedBox(height: 10,),
                          const Text('mal', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),)
                        ],
                      ), onPressed: () => next_page(ctx, 'mal'),)
                  ),


                  // meh
                  Container(
                      child: TextButton(child: Column(
                        children: [
                          Image.asset('assets/img/emoji/neutral.png', width:size.width/10),
                          SizedBox(height: 10,),
                          const Text('meh', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),)
                        ],
                      ), onPressed: () => next_page(ctx, 'meh'),)
                  ),


                  // bien
                  Container(
                      child: TextButton(child: Column(
                        children: [
                          Image.asset('assets/img/emoji/sonriente.png', width:size.width/10),
                          SizedBox(height: 10,),
                          const Text('bien', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),)
                        ],
                      ), onPressed: () => next_page(ctx, 'bien'),)
                  ),


                  // increible
                  Container(
                    padding: EdgeInsets.all(0),
                      child: TextButton(child: Column(
                        children: [
                          Image.asset('assets/img/emoji/famoso.png', width:size.width/10),
                          SizedBox(height: 10,),
                          const Text('increible', style: TextStyle(color: Colors.black54, fontWeight: FontWeight.bold, fontSize: 12),)
                        ],
                      ), onPressed: () => next_page(ctx, 'increible'),)
                  )


                ],
              ),),
              decoration: BoxDecoration(
                  color: Colors.transparent, borderRadius: BorderRadius.circular(20)),),),

            const Expanded(child: Text(''),),

            Container(
              padding: const EdgeInsets.only(bottom: 70),
              child:const Text('', style: TextStyle(fontSize: 16,)))
          ],)
    );
  }
}
