import 'dart:async';
import 'package:flutter/material.dart';
import 'package:psicodoc/question_daily.dart';
import 'package:psicodoc/start_weekly.dart';
import 'package:psicodoc/service/login_service.dart';
import 'package:psicodoc/service/config.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LogInPage extends StatefulWidget {
  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPage();
}

class _LogInPage extends State<LogInPage> {
  FocusNode myFocusNodeUsername = new FocusNode();
  FocusNode myFocusNodeEmail = new FocusNode();
  FocusNode myFocusNodePassword = new FocusNode();

  TextEditingController email_controller = new TextEditingController();
  TextEditingController password_controller = new TextEditingController();

  String message = "";
  bool visible = false;

  void login(BuildContext ctx) async {
    if(email_controller.value.text.isEmpty ||
        password_controller.value.text.isEmpty) {
      setState(() {
        message = "Debes llenar todos los campos";
        visible = true;
      });
    }
    else {
      RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if(!emailValid.hasMatch(email_controller.value.text)) {
        setState(() {
          message = "El email no es válido";
          visible = true;
        });
      }
      else {
        Future<Map<String, dynamic>> body = login_service(email_controller.value.text, password_controller.value.text);
        body.then((body) {

          if (body["data"] == "ok") {

            prefs.then((pref) {
              pref.setString("email", body["email"]);
              pref.setString("username", body["username"]);
              pref.setBool("loged", true);
            });

            setState(() {
              visible = false;
            });
            email_controller.text = "";
            password_controller.text = "";


            prefs.then((pref) {
              pref.setString("email", body["email"]);
              pref.setString("username", body["username"]);
              pref.setBool("loged", true);
              final date_feeling = pref.getString("date_feeling");

              if(date_feeling != null) {

                  final now = DateTime.now();
                  final current_date = date_feeling;
                  final date = current_date.toString().split("-");

                  if (date[1] == now.month.toString() &&
                      date[2] == now.day.toString()) {
                    // lo lleva a la pagina de preguntas
                    final route = MaterialPageRoute(
                        builder: (context) => QuestionDailyPage());
                    Navigator.push(ctx, route);
                  } else {
                    //  le pregunta por el dia de hoy
                    final route = MaterialPageRoute(
                        builder: (context) => StartWeeklyPage());
                    Navigator.push(ctx, route);
                  }

              }
              else {
                print("cuatro");
                final route = MaterialPageRoute(builder: (context) => StartWeeklyPage());
                Navigator.pushReplacement(ctx, route);
              }
            });

          }
          else if (body["data"] == "badcred") {
            setState(() {
              message = "El email o contraseña son incorrectos";
              visible = true;
            });
          }
          else if (body["data"] == "noexists") {
            setState(() {
              message = "El usuario no existe";
              visible = true;
            });
          }
          else{
            setState(() {
              message = "Error interno, intente mas tarde..";
              visible = true;
            });
          }

        });

      }
    }


    //Navigator.push(ctx, route);
  }


  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body:SingleChildScrollView(child: Column(children: [
        const SizedBox(height: 80,),
        Padding(padding: EdgeInsets.symmetric(horizontal: 30), child: const Text('¡Bienvenid@ de vuelta!', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),),


        const SizedBox(height: 20,),

        Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: TextFormField(
            controller: email_controller,
            focusNode: myFocusNodeEmail,
            decoration: InputDecoration(
                focusedBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                ),
                enabledBorder: const OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                labelText: 'Correo Electronico',
                labelStyle: TextStyle(
                    color: myFocusNodeEmail.hasFocus ? Colors.blue : Colors.black
                )
            ),
          ),
        ),


        const SizedBox(height: 10,),

        Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: TextFormField(
            controller: password_controller,
            obscureText: true,
            focusNode: myFocusNodePassword,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                labelText: 'Contraseña',
                labelStyle: TextStyle(
                    color: myFocusNodePassword.hasFocus ? Colors.blue : Colors.black
                )
            ),
          ),
        ),

        const SizedBox(height: 15,),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Visibility(child: Text(message, style: const TextStyle(color: Colors.red),), visible: visible,),
        ),

        const SizedBox(height: 15,),

        Container(
            width: size.width-60,
            child:
            Expanded(child:
            TextButton(
                onPressed: () {
                  login(context);
                },
                child: const Text('INICIAR SESION', style: TextStyle(fontSize: 15,),),
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

        ),
        const SizedBox(height: 30, child: null,),

        Container(
          child: const Text('¿Aun no tienes cuenta?'),
        ),
        Container(
          child: TextButton(onPressed: () => Navigator.pop(context), child: const Text('Registrate', style: TextStyle(fontWeight: FontWeight.bold),),),
        )
      ],),
    ));
  }
}

