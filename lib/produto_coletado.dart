class ProdutoColetado {
  int cod;
  String desc;
  int pallets;
  int lastros;
  int caixas;
  int unidades;
  String validade;

  ProdutoColetado(
      {required this.cod,
        required this.desc,
        required this.pallets,
        required this.lastros,
        required this.caixas,
        required this.unidades,
        required this.validade});

  @override
  String toString() {
    // TODO: implement toString
    return 'cod:$cod - $desc - p:$pallets - l:$lastros - c:$caixas - u:$unidades - $validade';
  }
}
