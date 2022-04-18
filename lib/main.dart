import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

//import 'db/Db.dart';
import 'db/Entity/produto.dart';
import 'produto_coletado.dart';
import 'ColetaProduto.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        ColetaProduto.routeName: (context) => const ColetaProduto(),
      },
      title: 'K-Inventory',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      home: const MyHomePage(title: 'Inventário'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MainPage();
}

class ScreenArguments {
  List produtosLista;
  String text;

  ScreenArguments(this.produtosLista, this.text);
}

class _MainPage extends State<MyHomePage> {
  List produtosLista = [];

  void _openColetaProduto() {
    Navigator.pushNamed(
      context,
      ColetaProduto.routeName,
      arguments: ScreenArguments(this.produtosLista, "TESTE"),
    ).then((_) {
      setState(() {
        // Call setState to refresh the page.
      });
    });
    setState(() {
      // _counter without calling setState(), then the build method would not be
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    super.dispose();
  }


  var txtTest = "";

  Future<void> _initData() async {
    String data =
        await DefaultAssetBundle.of(context).loadString("assets/base0111.json");
    final jsonResult = jsonDecode(data);
    print("json:");
    final p_930 = Produto.fromJson(jsonResult[_randInt(1, 7700)]);
    print(p_930);
    setState(() {
      txtTest = p_930.toString();
    });
  }

  _randInt(int min, int max) {
    final _random = Random();
    int next(int min, int max) => min + _random.nextInt(max - min);
    return next(min, max);
  }

  @override
  Widget build(BuildContext context) {
    _initData();

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(widget.title),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Expanded(
                child: Column(children: <Widget>[
              Text(txtTest),
              _criaCabecalhoTable(),
              _criaLista(produtosLista),
            ])),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openColetaProduto(),
        tooltip: 'Adicionar Item',
        child: const Icon(Icons.add),
      ),
    );
  }

  _criaLista(List produtos) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(children: <Widget>[
      for (var prod in produtos) RowProdutoColetado(produto: prod),
    ])));
  }

  _criaCabecalhoTable() {
    return Row(
      children: const <Widget>[
        ListHeader(text: 'Cod', flex: 2),
        ListHeader(text: 'Descrição', flex: 5),
        ListHeader(text: 'Pal'),
        ListHeader(text: 'Las'),
        ListHeader(text: 'Cx'),
        ListHeader(text: 'Un'),
        ListHeader(text: 'Data', flex: 3),
      ],
    );
  }
}

class RowProdutoColetado extends StatelessWidget {
  const RowProdutoColetado({
    Key? key,
    required this.produto,
  }) : super(key: key);

  final ProdutoColetado produto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        ListHeader(text: produto.cod.toString(), flex: 2),
        ListHeader(text: produto.desc.toString(), flex: 5),
        ListHeader(text: produto.pallets.toString()),
        ListHeader(text: produto.lastros.toString()),
        ListHeader(text: produto.caixas.toString()),
        ListHeader(text: produto.unidades.toString()),
        ListHeader(text: produto.validade.toString(), flex: 3),
      ],
    );
  }
}

class ListHeader extends StatelessWidget {
  const ListHeader({
    Key? key,
    required this.text,
    this.flex = 1,
  }) : super(key: key);

  final String text;
  final int flex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 40,
        decoration: BoxDecoration(border: Border.all(color: Colors.blueAccent)),
        child: Center(
            child: Text(
          text,
          textAlign: TextAlign.center,
        )),
      ),
    );
  }
}

/*

const Text('Informe código do produto',),
TextFormField(
  controller: newCodigoProduto,
  keyboardType: TextInputType.number,
  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
  decoration: const InputDecoration(
    hintText: 'Código Novo Produto',
  ),
  validator: (String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  },
),
*/
