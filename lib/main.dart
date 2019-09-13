import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: Home()));
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController weightController = TextEditingController();
  TextEditingController heightController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _infoText = "Informe seus dados!!!";

  void _resetFields() {
    weightController.text = "";
    heightController.text = "";
    setState(() {
      _infoText = "Informe seus dados!!!";
      _formKey = GlobalKey<FormState>();
    });
  }

  void _calculate() {
    setState(() {
      double weight = double.parse(weightController.text);
      double height = double.parse(heightController.text) / 100;

      double result = weight / (height * height);

      if (result < 18.5) {
        _infoText = "Abaixo do peso!";
      } else if (result >= 18.5 && result <= 24.9) {
        _infoText = "Peso normal!";
      } else if (result >= 25 && result <= 29.9) {
        _infoText = "Sobrepeso!";
      } else if (result > 30 && result <= 34.9) {
        _infoText = "Obesidade grau 1!";
      } else if (result > 35 && result <= 39.9) {
        _infoText = "Obesidade grau 2!";
      } else if (result > 35 && result <= 39.9) {
        _infoText = "Obesidade grau 3!";
      } else {
        _infoText = "Erro!!!";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Calculadora de IMC'),
          centerTitle: true,
          backgroundColor: Colors.teal,
          actions: <Widget>[
            IconButton(icon: Icon(Icons.refresh), onPressed: _resetFields)
          ],
        ),
        backgroundColor: Colors.white10,
        body: SingleChildScrollView(
          padding: EdgeInsets.fromLTRB(10.0, 0, 10.0, 0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Icon(
                  Icons.person_outline,
                  size: 120.0,
                  color: Colors.tealAccent,
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Peso (kg)",
                      labelStyle: TextStyle(color: Colors.tealAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.tealAccent, fontSize: 25.0),
                  controller: weightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira seu peso!";
                    }
                    if(value.length > 3){
                      return "Insira o peso correto";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: "Altura (cm)",
                      labelStyle: TextStyle(color: Colors.tealAccent)),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.tealAccent, fontSize: 25.0),
                  controller: heightController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Insira sua altura!";
                    }
                    if(value.length > 3){
                      return "Insira a altura correta";
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Container(
                    height: 50.0,
                    child: RaisedButton(
                      onPressed: (){
                        if(_formKey.currentState.validate()){
                          _calculate();
                        }
                      },
                      child: Text(
                        "Calcular",
                        style: TextStyle(color: Colors.white, fontSize: 25.00),
                      ),
                      color: Colors.teal,
                    ),
                  ),
                ),
                Text(_infoText,
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.tealAccent, fontSize: 25.0))
              ],
            ),
          )
        ));
  }
}
