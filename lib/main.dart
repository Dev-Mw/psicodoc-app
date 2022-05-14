import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:psicodoc/home.dart';
import 'package:psicodoc/service/config.dart';
import 'package:psicodoc/start.dart';
import 'package:psicodoc/question_daily.dart';
import 'package:psicodoc/start_weekly.dart';

void main() {
  runApp(const PsicodocApp());
}

class PsicodocApp extends StatelessWidget {
  const PsicodocApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page')
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  Color color_slide0 = Colors.black26;
  Color color_slide1 = Colors.black12;
  Color color_slide2 = Colors.black12;
  Color color_slide3 = Colors.black12;

  void init(BuildContext ctx) {
    prefs.then((pref) {
      final logged = pref.getBool("loged");
      final date_feeling = pref.getString("date_feeling");

      try {
        if(logged != null) {
          if(logged) {
            if(date_feeling != null) {

                final now = DateTime.now();
                final current_date_feeling = pref.getString("date_feeling").toString().split("-");
                final current_date_test = pref.getString("date_test").toString().split("-");

                  // pregunta si ya respondio el test diario
                  if (current_date_feeling[1] == now.month.toString() &&
                      current_date_feeling[2] == now.day.toString()) {
                    // pregiunta si ya hizo el test mensual
                    if (current_date_test[1] == now.month.toString()) {
                      print("va al home");
                      // val al home
                      final route = MaterialPageRoute(
                          builder: (context) => HomePage());
                      Navigator.push(ctx, route);
                    }
                    else {
                      // va a contestar el test mensual
                      final route = MaterialPageRoute(
                          builder: (context) => QuestionDailyPage());
                      Navigator.push(ctx, route);
                    }
                  } else {
                    //  le pregunta por el dia de hoy
                    final route = MaterialPageRoute(
                        builder: (context) => StartWeeklyPage());
                    Navigator.push(ctx, route);
                  }


            }

          }
        }
      }
      catch(e){
        print("Err..");
        print(e);
      }
    });

  }

  void start(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (context) => StartPage());
    Navigator.push(ctx, route);
  }

  void register() {
    print('registro');
  }

  dynamic changePage(int page, other) {
    switch (page) {
      case 0:
        setState(() {
          color_slide0 = Colors.black26;
          color_slide1 = Colors.black12;
          color_slide2 = Colors.black12;
          color_slide3 = Colors.black12;
        });
        break;
      case 1:
        setState(() {
          color_slide0 = Colors.black12;
          color_slide1 = Colors.black26;
          color_slide2 = Colors.black12;
          color_slide3 = Colors.black12;
        });
        break;
      case 2:
        setState(() {
          color_slide0 = Colors.black12;
          color_slide1 = Colors.black12;
          color_slide2 = Colors.black26;
          color_slide3 = Colors.black12;
        });
        break;
      case 3:
        setState(() {
          color_slide0 = Colors.black12;
          color_slide1 = Colors.black12;
          color_slide2 = Colors.black12;
          color_slide3 = Colors.black26;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ctx = context;

    init(ctx);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child:
              CarouselSlider(
                options: CarouselOptions(height: 300.0, onPageChanged: changePage, enableInfiniteScroll: false),
                items: [0,1,2,3].map((i) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.symmetric(horizontal: 15.0),
                          decoration: const BoxDecoration(
                              color: Colors.amber
                          ),
                          child: Text('Text $i', style: const TextStyle(fontSize: 16.0),)
                      );
                    },
                  );
                }).toList(),
              )
            ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                Container(child: const Text(''), decoration: BoxDecoration(color: color_slide0, borderRadius: const BorderRadius.all(Radius.circular(20))), width: 11, height: 11,),
                  const SizedBox(width: 6,),
                  Container(child: const Text(''), decoration: BoxDecoration(color: color_slide1, borderRadius: const BorderRadius.all(Radius.circular(20))), width: 11, height: 11,),
                  const SizedBox(width: 6,),
                  Container(child: const Text(''), decoration: BoxDecoration(color: color_slide2, borderRadius: const BorderRadius.all(Radius.circular(20))), width: 11, height: 11,),
                  const SizedBox(width: 6,),
                  Container(child: const Text(''), decoration: BoxDecoration(color: color_slide3, borderRadius: const BorderRadius.all(Radius.circular(20))), width: 11, height: 11,),
              ],),
            const SizedBox(height: 20,),
            Container(
              child: TextButton(
                onPressed: () {
                  start(ctx);
                },
                child: const Text('COMIENZA', style: TextStyle(fontSize: 20,),),
                style: ButtonStyle(
                  minimumSize: MaterialStateProperty.all<Size>(Size(size.width-60, 50)),
                    padding: MaterialStateProperty.all(const EdgeInsets.all(20)),
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
          ],
        ),
      ),
    );
  }
}
