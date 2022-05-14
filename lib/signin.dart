import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:psicodoc/login.dart';
import 'package:psicodoc/service/signin_service.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPage();
}

class _SignInPage extends State<SignInPage> {
  FocusNode myFocusNodeUsername = new FocusNode();
  FocusNode myFocusNodeEmail = new FocusNode();
  FocusNode myFocusNodeAge = new FocusNode();
  FocusNode myFocusNodeCareer = new FocusNode();
  FocusNode myFocusNodePassword = new FocusNode();

  TextEditingController name_controller = new TextEditingController();
  TextEditingController email_controller = new TextEditingController();
  TextEditingController age_controller = new TextEditingController();
  TextEditingController career_controller = new TextEditingController();
  TextEditingController password_controller = new TextEditingController();
  String message = "";
  bool visible = false;

  void login(BuildContext ctx) {
    final route = MaterialPageRoute(builder: (context) => LogInPage());
    Navigator.push(ctx, route);
  }

  void signin(BuildContext ctx) {
    if(name_controller.value.text.isEmpty ||
        email_controller.value.text.isEmpty ||
        age_controller.value.text.isEmpty ||
        career_controller.value.text.isEmpty ||
        password_controller.value.text.isEmpty) {
      setState(() {
        message = "Debes llenar todos los campos";
        visible = true;
      });
    }
    else {
      RegExp passValid = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!-_@#\$&*~]).{8,}$');
      RegExp emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

      if(!emailValid.hasMatch(email_controller.value.text)) {
        setState(() {
          message = "El email no es válido";
          visible = true;
        });
      }
      else {
        if(!passValid.hasMatch(password_controller.value.text)) {
          setState(() {
            message = "La contraseña debe tener mas de 8 caracteres, contener al menos una mayuscula y minusculas y números";
            visible = true;
          });
        }
        else{

          Future<Map<String, dynamic>> body = signin_service(name_controller.value.text,
              email_controller.value.text,
              age_controller.value.text,
              career_controller.value.text,
              password_controller.value.text);

          body.then((body) {
            if(body["data"] == "ok") {
              setState(() {
                visible = false;
              });

              name_controller.text = "";
              email_controller.text = "";
              age_controller.text = "";
              career_controller.text = "";
              password_controller.text = "";

              final route = MaterialPageRoute(builder: (context) => LogInPage());
              Navigator.push(ctx, route);
            }
            else {
              setState(() {
                visible = true;
                message = "El email ya existe, sino, intentelo mas tarde..";
              });
            }
          });

        }
      }
    }


    //Navigator.push(ctx, route);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SingleChildScrollView(child: Column(children: [
        const SizedBox(height: 80,),
        const Text('Registro', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),

        const SizedBox(height: 20,),

        Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: TextFormField(
            controller: name_controller,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            focusNode: myFocusNodeUsername,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                labelText: 'Nombre de Usuario',
                labelStyle: TextStyle(
                    color: myFocusNodeUsername.hasFocus ? Colors.blue : Colors.black
                )
            ),
          ),
        ),

        const SizedBox(height: 10,),

        Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: TextFormField(
            controller: email_controller,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            focusNode: myFocusNodeEmail,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
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
            controller: age_controller,
            keyboardType: TextInputType.number,
            textInputAction: TextInputAction.next,
            focusNode: myFocusNodeAge,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                labelText: 'Edad',
                labelStyle: TextStyle(
                    color: myFocusNodeAge.hasFocus ? Colors.blue : Colors.black
                )
            ),
          ),
        ),

        const SizedBox(height: 10,),

        Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: TextFormField(
            controller: career_controller,
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.next,
            focusNode: myFocusNodeCareer,
            decoration: InputDecoration(
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.black26, width: 1.0),
                ),
                labelText: 'Carrera o grado',
                labelStyle: TextStyle(
                    color: myFocusNodeCareer.hasFocus ? Colors.blue : Colors.black
                )
            ),
          ),
        ),

        const SizedBox(height: 10,),

        Padding(padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 30),
          child: TextFormField(
            controller: password_controller,
            obscureText: true,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
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
                    signin(context);
                  },
                  child: const Text('REGISTRARME', style: TextStyle(fontSize: 15,),),
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
          child: const Text('¿Ya tienes cuenta?'),
        ),
        Container(
          child: TextButton(onPressed: () => login(context), child: const Text('Iniciar Sesión', style: TextStyle(fontWeight: FontWeight.bold),),),
        ),

        const SizedBox(height: 50, child: null,),
      ],),
    ));
  }
}

