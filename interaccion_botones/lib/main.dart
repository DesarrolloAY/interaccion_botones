import 'package:flutter/material.dart';

class LoginData {
  String username = '';
  String password = '';
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key); 

  @override
  _MyAppState createState() => _MyAppState(); 
}

class _MyAppState extends State<MyApp> { 
  final LoginData _loginData = LoginData();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  
  @override
  Widget build(BuildContext inContext) {
    return MaterialApp(
      title: 'Codigo Flutter',
      home: Scaffold(
        appBar: AppBar(title: const Text('Código Flutter')),
        body: Container(
          padding: const EdgeInsets.all(50.0),
          child: Formulario(formKey: _formKey, loginData: _loginData)
        )
      )
    );
  }
}

class Formulario extends StatelessWidget{
  const Formulario({
    Key? key, // Key puede ser nulo
    required GlobalKey<FormState> formKey, 
    required LoginData loginData, 
  }) : _formKey = formKey, _loginData = loginData, super(key: key);

  final GlobalKey<FormState> _formKey;
  final LoginData _loginData;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            validator: (String? inValue){ 
              if (inValue == null || inValue.isEmpty){
                return 'Introduce nombre de usuario: ';
              }
              return null;
            },
            onSaved: (String? inValue) { 
              _loginData.username = inValue ?? '';
            },
            decoration: const InputDecoration(
              hintText: 'none@none.com', 
              labelText: 'Usuario (eMail)'
            )
          ),
          TextFormField(
            obscureText: true,
            validator: (String? inValue){ // Valor puede ser nulo
              if (inValue == null || inValue.length < 10){
                return 'La contraseña debe tener al menos 10 caracteres';
              }
              return null;
            },
            onSaved: (String? inValue) { // Valor puede ser nulo
              _loginData.password = inValue ?? '';
            },
            decoration: const InputDecoration(
              hintText: 'Contraseña', 
              labelText: 'Contraseña'
            )
          ),
          ElevatedButton( // RaisedButton está obsoleto, usar ElevatedButton
            child: const Text('Acceso'),
            onPressed: () {
              if (_formKey.currentState!.validate()) { // Usar ! para indicar que no es nulo
                _formKey.currentState!.save();
                print('Usuario: ${_loginData.username}');
                print('Contraseña: ${_loginData.password}');
              }
            }
          )
        ],
      )
    );
  }
}