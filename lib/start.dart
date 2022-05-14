import 'package:flutter/material.dart';
import 'package:psicodoc/question_daily.dart';
import 'package:psicodoc/service/config.dart';
import 'package:psicodoc/signin.dart';
import 'package:psicodoc/start_weekly.dart';


class StartPage extends StatelessWidget {

  void next_page(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (context) => StartPageTwo());
    Navigator.push(ctx, route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ctx = context;

    return Scaffold(
      body: Column(children: [
        Image.asset('assets/img/5474794-min.jpeg'),
        Expanded(child:
          Container(
            padding: EdgeInsets.all(30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Mantén un Diario', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
                SizedBox(height: 20,),
                Text('Mantén un diario personal, ¡sin escribir una sola palabra! Sólo elige tus Estados y Actividades cuando gustes.', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w100),),
                SizedBox(height: 20,),
                Text('Al usar esta aplicación aceptas sus', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w100),),
                TextButton(onPressed: () => print('hola'), child: Text('Términos de uso', style: TextStyle(fontSize: 17, fontWeight: FontWeight.w100),))
              ],
            ),
          )
        ),
        Container(
          child: TextButton(
              onPressed: () => next_page(ctx),
              child: const Text('SIGUIENTE', style: TextStyle(fontSize: 20,),),
              style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(size.width-60, 50)),
                  padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                  foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40)
                      )
                  )
              )
          ),
        ),
        const SizedBox(height: 40, child: null,),
      ],),
    );
  }
}


class StartPageTwo extends StatelessWidget {

  void next_page(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => const SignInPage());
    Navigator.push(context, route);
  }

  void question_daily_page(BuildContext context) {
    final route = MaterialPageRoute(builder: (context) => StartWeeklyPage());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(children: [
        Image.asset('assets/img/5482-min.jpeg', cacheHeight: (size.height~/4).toInt(),),
        Expanded(child:
        Container(
          padding: EdgeInsets.all(30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Ayúdanos a mejorar Psicodoc', style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),),
              SizedBox(height: 20,),
              Text('¿Accedes a compartir datos anónimos?', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),),
              SizedBox(height: 10,),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                      child: Image.asset('assets/img/problem.png', width: 15,)
                    ),
                    TextSpan(
                      text: "  Enviar informes de fallos ",
                        style: TextStyle(color: Colors.black54)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              RichText(
                text: TextSpan(
                  children: [
                    WidgetSpan(
                        child: Image.asset('assets/img/statistic.png', width: 15,)
                    ),
                    TextSpan(
                      text: "  Proporcionar uso de app anonimizado ",
                      style: TextStyle(color: Colors.black54)
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              Text('Puedes cambiarlo cuando quieras. Atesoramos tu privacidad, y solo tú puedes acceder a tus datos.', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w100),),
              SizedBox(height: 10,),
              Text('¡Gracias por hacer Psicodoc mejor cada día!', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
              SizedBox(height: 20,),
              TextButton(onPressed: () => print('hola'),
                  child: RichText(
                    text: TextSpan(
                      children: [
                        WidgetSpan(
                            child: Image.asset('assets/img/lock.png', width: 12,)
                        ),
                        TextSpan(
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.blue),
                          text: " Leer políticas de Privacidad",
                        ),
                      ],
                    ),
                  ),

              )
            ], // #00A7CD
          ),
        )
        ),
        Container(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: Row(children: [
            TextButton(
                onPressed: () {
                  prefs.then((pref) {
                    pref.setBool("terms", false);
                  });
                  question_daily_page(context);
                },
                child: const Text('No estoy de acuerdo', style: TextStyle(fontSize: 15,),),
                style: ButtonStyle(
                    //minimumSize: MaterialStateProperty.all<Size>(Size(size.width-60, 50)),
                    padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),

                    foregroundColor: MaterialStateProperty.all<Color>(Colors.blue),

                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(40),
                        )
                    )
                )
            ),

            const SizedBox(height: 7,),

            Expanded(child:
              TextButton(
                  onPressed: () {
                    prefs.then((pref) {
                      pref.setBool("terms", true);
                    });
                    next_page(context);
                  },
                  child: const Text('De acuerdo', style: TextStyle(fontSize: 15,),),
                  style: ButtonStyle(
                      //minimumSize: MaterialStateProperty.all<Size>(Size(size.width-60, 50)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(16)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          )
                      )
                  )
              ),
            )
          ],)
        ),
        const SizedBox(height: 30, child: null,),
      ],),
    );
  }
}