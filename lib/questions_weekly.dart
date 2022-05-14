import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:psicodoc/home.dart';
import 'package:psicodoc/service/config.dart';
import 'package:psicodoc/service/test_service.dart';


class QuestionsWeeklyPage extends StatefulWidget {
  const QuestionsWeeklyPage({Key? key}) : super(key: key);

  @override
  State<QuestionsWeeklyPage> createState() => _QuestionsWeeklyPageState();
}

enum Number_Answers { one, two, three, four }

class Questions {
  String name = "";
  List<String> questions = [];
  List<Color> colors = [];
  Questions(this.name, this.questions, this.colors);

}





class _QuestionsWeeklyPageState extends State<QuestionsWeeklyPage> {
  int _counter = 0;

  Color color_slide0 = Colors.black26;
  Color color_slide1 = Colors.black12;
  Color color_slide2 = Colors.black12;
  Color color_slide3 = Colors.black12;

  CarouselController c = CarouselController();

  final Map<String, String> answers = {};

  final List<Questions> questions = [
    Questions("Tristeza", [
      "No me siento triste.",
      "Me siento triste gran parte del tiempo.",
      "Estoy triste todo el tiempo.",
      "Estoy tan triste o soy tan feliz que no puedo soportarlo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Pesimismo", [
      "No estoy desalentado respecto de mi futuro.",
      "Me siento más desalentado respecto de mi futuro que lo que solia estarlo.",
      "No espero que las cosas funcionen para mí.",
      "Siento que no hay esperanza para mi futuro y que sólo se puede empeorar."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Fracaso", [
      "No me siento como un fracasado.",
      "He fracasado más de lo que hubiera debido.",
      "Cuando miro hacia atrás veo muchos fracasos.",
      "Siento que como persona soy un fracaso total."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Pérdida de Placer", [
      "Obtengo tanto placer como siempre por las cosas de las que disfruto.",
      "No disfruto tanto de las cosas como solía hacerlo.",
      "Obtengo muy poco placer de las cosas de las que solía disfrutar.",
      "No puedo obtener ningun placer de las cosas de las que solía disfrutar."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Sentimientos de Culpa", [
      "No me siento particularmente culpable.",
      "Me siento culpable respecto de varias cosas que he hecho o que debería haber hecho.",
      "Me siento bastante culpable la mayor parte del tiempo.",
      "Me siento culpable todo el tiempo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Sentimientos de Castigo", [
      "No siento que estoy siendo castigado.",
      "Siento que tal vez pueda ser castigado.",
      "Espero ser castigado.",
      "Siento que estoy siendo castigado."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Disconformidad con Uno Mismo", [
      "Siento acerca de mí lo mismo que siempre.",
      "He perdido la confianza en mí mismo.",
      "Estoy decepcionado conmigo mismo.",
      "No me gusto a mí mismo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Autocrítica", [
      "No me critico ni me culpo más de lo habitual.",
      "Estoy más crítico conmigo mismo de lo que solía estarlo.",
      "Me critico a mí mismo por todos mis errores.",
      "Me culpo a mí mismo por todo lo malo que sucede."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Pensamientos o Deseos Suicidas", [
      "No tengo ningún pensamiento de matarme.",
      "He tenido pensamientos de matarme, pero no lo haría.",
      "Querría matarme.",
      "Me mataría si tuviera la oportunidad de hacerlo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Llanto", [
      "No lloro más de lo que solía hacerlo.",
      "Lloro más de lo que solía hacerlo.",
      "Lloro por cualquier pequeñez.",
      "Siento ganas de llorar pero no puedo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Agitación", [
      "No estoy más inquieto o tenso que lo habitual.",
      "Me siento más inquieto o tenso que lo habitual.",
      "Estoy tan inquieto o agitado que me es dificil quedarme quieto.",
      "Estoy tan inquieto o agitado que tengo que estar siempre en movimiento o haciendo algo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Pérdida de Interés", [
      "No he perdido el interés en otras actividades o personas.",
      "Estoy menos interesado que antes en otras personas o cosas.",
      "He perdido casi todo el interés en otras personas o cosas.",
      "Me es dificil interesarme por algo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Indecisión", [
      "Tomo mis decisiones tan bien como siempre.",
      "Me resulta más dificil que de costumbre tomas decisiones.",
      "Encuentro mucha más dificultad que antes para tomar decisiones.",
      "Tengo problemas para tomar cualquier decisión."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Desvalorización", [
      "No siento que yo no sea valioso.",
      "No me considero a mí mismo tan valioso y útil como solía considerarme.",
      "Me siento menos valioso cuando me comparo con otros.",
      "Siento que no valgo nada."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Pérdida de Energía", [
      "Tengo tanta energía como siempre.",
      "Tengo menos energía que la que solía tener.",
      "No tengo suficiente energía para hacer demasiado.",
      "No tengo energía suficiente para hacer nada."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Cambios en los Hábitos de Sueño", [
      "No he experimentado ningún cambio en mis hábitos de sueño.",
      "(a) Duermo un poco más que lo habitual.\n(b) Duermo un poco menos que lo habitual.",
      "(a) Duermo mucho más que lo habitual.\n(b) Duermo mucho menos que lo habitual.",
      "(a) Dumero la mayor parte del día.\n(b) Me despierto 1-2 horas más temprano y no puedo volver a dormirme."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Irritabilidad", [
      "No estoy más irritable que lo habitual.",
      "Estoy más irritable que lo habitual.",
      "Estoy mucho más irritable que lo habitual.",
      "Estoy irritable todo el tiempo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Cambios en el Apetito", [
      "No he experimentado ningún cambio en mi apetito.",
      "(a) Mi apetito es un poco menor que lo habitual.\n(b) Mi apetito es un poco mayor que lo habitual.",
      "(a) Mi apetito es mucho menor que antes.\n(b) Mi apetito es mucho mayor que lo habitual.",
      "(a) No tengo en apetito en absoluto.\n(b) Quiero comer todo el tiempo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Dificultad de Concentración", [
      "Puedo concentrarme tan bien como siempre.",
      "No puedo concentrarme tan ien como habitualmente.",
      "Me es dificil mantener la mente en algo por mucho tiempo.",
      "Encuentro que no pueod concentrarme en nada."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Cansancio o Fatiga", [
      "No estoy más cansado o fatigado que lo habitual.",
      "Me fatigo o me canso más fácilmente que lo habitual.",
      "Estoy demasiado fatigado o cansado paa hacer muchas de las cosas que solía hacer.",
      "Estoy demasiado fatigo o cansado para hacer la mayoría de las cosas que solía hacer."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),
    Questions("Pérdida de Interes en el Sexo", [
      "No he notado ningún cambio reciente en mi interés por el sexo.",
      "Estoy menos interesado en el sexo de lo que solía estarlo.",
      "Ahora estoy mucho menos ineteresado en el sexo.",
      "He perdido completamente el interés en el sexo."
    ], [Colors.transparent, Colors.transparent, Colors.transparent, Colors.transparent]),

  ];

  void home_page(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (context) => HomePage());
    Navigator.push(ctx, route);
  }

  void answer_validate() {
    if(answers.length != 21) {
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) => _buildPopupDialogIncomplete(context),
      );
    }
    else {
      prefs.then((pref) {
        final String email = pref.getString("email").toString();
        final String username = pref.getString("username").toString();

        Future<Map<String, dynamic>> res = test_service(
            email, username, answers);

        res.then((body) {
          final now = DateTime.now();
          pref.setString("date_test", "${now.year}-${now.month}-${now.day}");

          showDialog(
            barrierDismissible: false,
            context: context,
            builder: (BuildContext context) => _buildPopupDialog(context),
          );
        });
      });
    }
  }

  void probar(Map<String, String> answer) {
    answers[answer["q"] ?? "null"] = answer["a"] ?? "null";
  }


  dynamic changePage(int page, answer) {

  }

  //SingingCharacter? _character = SingingCharacter.one;

  List<Widget> res(Size size) {

    final q = [];
    for (var i = 0; i < questions.length; i++){
      q.insert(i, i);
    }

    List<Widget> r = q.map((i) {

      return Builder(
        builder: (BuildContext context) {
          return Container(
            alignment: Alignment.topLeft,
              width: MediaQuery.of(context).size.width,
              margin: const EdgeInsets.symmetric(horizontal: 25.0),
              decoration: const BoxDecoration(
                  color: Colors.transparent
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  SizedBox(height: 30,),
                Text('${i+1}. ${questions[i].name}', style: const TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),),

                SizedBox(height: 30,),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: questions[i].colors[0]),
                    child: FlatButton(
                      minWidth: 30.0,
                      child: Text("1. "+ questions[i].questions[0], style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        setState(() {
                          questions[i].colors[0] = Colors.lightGreen;
                          questions[i].colors[1] = Colors.transparent;
                          questions[i].colors[2] = Colors.transparent;
                          questions[i].colors[3] = Colors.transparent;

                          this.probar({"q": questions[i].name, "a": questions[i].questions[0]});
                        });
                        print({"q": questions[i].name, "a": questions[i].questions[0]});


                      },
                    ),),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: questions[i].colors[1]),
                    child: FlatButton(
                      minWidth: 30.0,
                      child: Text("2. "+ questions[i].questions[1], style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        setState(() {
                          questions[i].colors[0] = Colors.transparent;
                          questions[i].colors[1] = Colors.lightGreen;
                          questions[i].colors[2] = Colors.transparent;
                          questions[i].colors[3] = Colors.transparent;

                        });
                        probar({"q": questions[i].name, "a": questions[i].questions[1]});
                      },
                    ),),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: questions[i].colors[2]),
                    child: FlatButton(
                      minWidth: 30.0,
                      child: Text("3. "+ questions[i].questions[2], style: TextStyle(fontSize: 16),),
                      onPressed: () {
                        setState(() {
                          questions[i].colors[0] = Colors.transparent;
                          questions[i].colors[1] = Colors.transparent;
                          questions[i].colors[2] = Colors.lightGreen;
                          questions[i].colors[3] = Colors.transparent;

                        });
                        probar({"q": questions[i].name, "a": questions[i].questions[2]});
                      },
                    ),),

                  SizedBox(height: 10,),

                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10)), color: questions[i].colors[3]),
                    child: FlatButton(
                    minWidth: 30.0,
                    child: Text("4. "+ questions[i].questions[3], style: TextStyle(fontSize: 16),),
                    onPressed: () {
                      setState(() {
                        questions[i].colors[0] = Colors.transparent;
                        questions[i].colors[1] = Colors.transparent;
                        questions[i].colors[2] = Colors.transparent;
                        questions[i].colors[3] = Colors.lightGreen;

                      });

                      probar({"q": questions[i].name, "a": questions[i].questions[3]});
                    },
                  ),)


              ],)
          );
        },
      );
    }).toList();

    return r;
  }




  Widget _buildPopupDialog(BuildContext context) {
    return new AlertDialog(
      title: const Text('¡Has completado tu registro!', style: TextStyle(fontSize: 24, color: Colors.white), textAlign: TextAlign.center,),
      backgroundColor: Colors.lightGreen,
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            home_page(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Continuar', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }

  Widget _buildPopupDialogIncomplete(BuildContext context) {
    return new AlertDialog(
      title: const Text('Lo sentimos, pero te falta por seleccionar alguna(s)', style: TextStyle(fontSize: 24, color: Colors.white), textAlign: TextAlign.center,),
      backgroundColor: Colors.redAccent,
      actions: <Widget>[
        new FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          textColor: Theme.of(context).primaryColor,
          child: const Text('Aceptar', style: TextStyle(color: Colors.white),),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final ctx = context;


    return Scaffold(
        body:
            SafeArea(child:
            Stack(children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child:
            CarouselSlider(
              carouselController: c,
              options: CarouselOptions(height: size.height, viewportFraction: 0.95, onPageChanged: changePage, enableInfiniteScroll: false, autoPlay: false),
              items: res(size),
            )
            ),

          ]),
              Positioned(child: FlatButton(onPressed: () => c.previousPage(), child: Text('< Atras')), bottom: 40, left: 20,),
              Positioned(child: FlatButton(onPressed: () => c.nextPage(), child: Text('Siguiente >')), bottom: 40, right: 20,)

            ],)
        ),
      floatingActionButton: FloatingActionButton(child: Icon(Icons.done), onPressed: () {

        // VALIDATE TEST
        answer_validate();
        /*
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) => _buildPopupDialog(context),
        );*/
      }, backgroundColor: Colors.green,),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,

    );

  }
/*
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ctx = context;


    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(child:
            CarouselSlider(
              carouselController: c,
              options: CarouselOptions(onPageChanged: changePage, enableInfiniteScroll: false, autoPlay: false),
              items: res(size),
            )
            ),
          ],
        ),
      ),
    );
  }*/
}
