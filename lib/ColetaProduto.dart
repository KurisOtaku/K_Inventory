// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:k_inventory/produto_coletado.dart';
import 'package:intl/intl.dart';

import 'main.dart';

// A Widget that extracts the necessary arguments from
// the ModalRoute.

class ColetaProduto extends StatelessWidget {
  static const routeName = '/extractArguments';

  const ColetaProduto({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return InsertProduto(title: 'Inventário');
  }
}

class InsertProduto extends StatefulWidget {
  const InsertProduto({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<InsertProduto> createState() => _InsertProduto();
}

class _InsertProduto extends State<InsertProduto> {
  var produtosLista = [];

  final TextEditingController controllerCod = TextEditingController();
  final TextEditingController controllerPallets = TextEditingController();
  final TextEditingController controllerLastros = TextEditingController();
  final TextEditingController controllerCaixas = TextEditingController();
  final TextEditingController controllerUnidades = TextEditingController();
  int cod = 0;
  int pallet = 0;
  int lastro = 0;
  int caixa = 0;
  int unidades = 0;
  var validade = null;
  var _validade = null;
  String prodName = "Nome do Produto";
  String txtDateButton = "Selecionar Data";
  var txtEditar = "Adicionar Produtos";

  void _addProduto() {
    if (testIt()) {
      correctValues();
      var produto = ProdutoColetado(
        cod: int.parse(controllerCod.text),
        desc: prodName,
        pallets: pallet,
        lastros: lastro,
        caixas: caixa,
        unidades: unidades,
        validade: validade,
      );
      produtosLista.add(produto);
      _clearList();
    //  Navigator.pop(context);
    } else {
      final snackBar = SnackBar(
        content: const Text("Parece que você não preencheu correto!"),
        action: SnackBarAction(
          label: 'OPA',
          onPressed: () {
            // Some code to undo the change.
          },
        ),
      );

      // Find the ScaffoldMessenger in the widget tree
      // and use it to show a SnackBar.
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
    _clearList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute
    // settings and cast them as ScreenArguments.
    final args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;

    bool multiploscadastros = false;

    produtosLista = args.produtosLista;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(txtEditar),
      ),
      body: Container(
        alignment: Alignment.topCenter,
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              FormField(
                controller: controllerCod,
                hint_Text: "Código Produto",
              ),
              Container(
                width: 1000,
                height: 50,
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.blueAccent)),
                child: Center(
                  child: Text(prodName),
                ),
              ),
              FormField(
                controller: controllerPallets,
                hint_Text: "Pallets",
              ),
              FormField(
                controller: controllerLastros,
                hint_Text: "Lastros",
              ),
              FormField(
                controller: controllerCaixas,
                hint_Text: "Caixas",
              ),
              FormField(
                controller: controllerUnidades,
                hint_Text: "Unidades",
              ),
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                          context: context,
                          initialDate:
                              validade == null ? DateTime.now() : validade,
                          firstDate: DateTime(2022),
                          lastDate: DateTime(2036))
                      .then((date) {
                    setState(() {
                      if (date != null) {
                        final f = new DateFormat('dd/MM/yyyy');
                        txtDateButton = f.format(date);
                        _validade = date;
                      }
                    });
                  });
                },
                child: Text(txtDateButton),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,

        children: [
          FloatingActionButton(
            onPressed: () => _addProduto(),
            backgroundColor: Colors.green,
            tooltip: 'Adicionar Produto',
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () => _clearList(),
            backgroundColor: Colors.red,
            tooltip: 'Limpar Lista',
            child: const Icon(Icons.cancel),
          ),
        ],
      ),
    );
  }

  bool testIt() {
    try {
      if (controllerCod.text == "" || controllerCod.text == null) {
        return false;
      }
      if (int.parse(controllerCod.text) < 1) {
        return false;
      }
      return true;
    } on Exception catch (_) {
      return false;
    }
  }

  void correctValues() {
    controllerPallets.text == ""
        ? pallet = 0
        : pallet = int.parse(controllerPallets.text);
    controllerLastros.text == ""
        ? lastro = 0
        : lastro = int.parse(controllerLastros.text);
    controllerCaixas.text == ""
        ? caixa = 0
        : caixa = int.parse(controllerCaixas.text);
    controllerUnidades.text == ""
        ? unidades = 0
        : unidades = int.parse(controllerCaixas.text);
    final f = new DateFormat('dd/MM/yyyy');
    _validade == null
        ? validade = "00/00/0000"
        : validade = f.format(_validade);
  }

  _clearList() {
    setState(() {
      controllerCod  .text =	"";
      controllerPallets  .text =	"";
      controllerLastros  .text =	"";
      controllerCaixas   .text =	"";
      controllerUnidades .text =	"";
      cod = 0;
      pallet = 0;
      lastro = 0;
      caixa = 0;
      unidades = 0;
      validade = null;
      _validade = null;
      txtDateButton = "Selecionar Data";
    });
  }
}

class FormField extends StatelessWidget {
  const FormField({Key? key, required this.controller, required this.hint_Text})
      : super(key: key);

  final TextEditingController controller;
  final String hint_Text;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      decoration: InputDecoration(
        hintText: hint_Text,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return 'Please enter some text';
        }
        return null;
      },
    );
  }
}
