import 'package:flutter/material.dart';
import 'package:psicodoc/home.dart';
import 'package:psicodoc/questions_weekly.dart';


class QuestionDailyPage extends StatelessWidget {

  void next_page(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (context) => QuestionsWeeklyPage());
    Navigator.push(ctx, route);
  }

  void omit(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (context) => HomePage());
    Navigator.push(ctx, route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ctx = context;
    final name = "Dario";

    return Scaffold(
        body:  Column(
          children: [
            Padding(padding: const EdgeInsets.only(top: 80, bottom: 20), child: Text('Buenas tardes',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 23), textAlign: TextAlign.center,),),

            const Expanded(child: Text(''),),

            Padding(padding: EdgeInsets.only(left: 20, right: 20), child:

                Container(
                  height: 100,
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child:
                  TextButton(
                      onPressed: () {
                        this.next_page(ctx);
                      },
                      child: Row(
                        children: [
                          //const Text('Imagen'),
                          const SizedBox(width: 20,),
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('ES HORA DE REGISTRARSE', style: TextStyle(color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),),
                              const Text('¿Qué tal te ha ido esta semana?', style: TextStyle(color: Colors.white,))
                            ],)
                        ],),
                      style: ButtonStyle(
                        //minimumSize: MaterialStateProperty.all<Size>(Size(size.width-60, 50)),
                          padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                          backgroundColor: MaterialStateProperty.all<Color>(Colors.green),
                          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)
                              )
                          )
                      )
                  ),)
            ),

            const Expanded(child: Text(''),),

            Container(
              padding: const EdgeInsets.only(bottom: 30),
              child:
              TextButton(
                  onPressed: () => { this.omit(ctx) },
                  child: const Text('OMITIR', style: TextStyle(fontSize: 16,),),
                  style: ButtonStyle(
                    //minimumSize: MaterialStateProperty.all<Size>(Size(size.width-60, 50)),
                      padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                      backgroundColor: MaterialStateProperty.all<Color>(Colors.black54),
                      foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(40)
                          )
                      )
                  )
              ),)
          ],)
    );
  }
}
