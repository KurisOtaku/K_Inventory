class Produto {
  /*
   01.11
  Codigo
  Descricao
  Tipo Marca
  Embalagem
  Vasilhame1173,
  Garrrafeira
  Fator
  Caixas Pallet
  Lastro
   */
  final int codigo;
  final String descricao;
  final String tipomarca;
  final String embalagem;
  final int vasilhame;
  final int garrafeira;
  final int unidadescaixa; //FATOR
  final int caixaspallet;
  final int lastrospallet;

  Produto(
      {required this.codigo,
      required this.descricao,
      required this.tipomarca,
      required this.embalagem,
      required this.vasilhame,
      required this.garrafeira,
      required this.unidadescaixa,
      required this.caixaspallet,
      required this.lastrospallet});

  factory Produto.fromJson(Map<String, dynamic> data) {
    final codigo = data['Codigo'] as int;
    final descricao = data['Descricao'] as String;
    final tipomarca = data['Tipo Marca'] as String;
    final embalagem = data['Embalagem'] as String;
    final vasilhame = data['Vasilhame'] as int;
    final garrafeira = data['Garrrafeira'] as int;
    final unidadescaixa = data['Fator'] as int;
    final caixaspallet = data['Caixas Pallet'] as int;
    late final lastrospallet;
    try {
      lastrospallet = data['Lastro'] as int;
    } on Exception catch (_) {
      lastrospallet = 0;
    }
    return Produto(
        codigo: codigo,
        descricao: descricao,
        tipomarca: tipomarca,
        embalagem: embalagem,
        vasilhame: vasilhame,
        garrafeira: garrafeira,
        unidadescaixa: unidadescaixa,
        caixaspallet: caixaspallet,
        lastrospallet: lastrospallet);
  }

  @override
  String toString() {
    final string =
        '{Codigo: $codigo, Descricao: $descricao, Tipo Marca: $tipomarca, Embalagem: $embalagem, Vasilhame: $vasilhame, Garrrafeira: $garrafeira, Fator: $unidadescaixa, Caixas Pallet: $caixaspallet, Lastro: $lastrospallet}';
    return string;
  }
}
