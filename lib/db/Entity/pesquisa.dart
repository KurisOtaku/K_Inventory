// ignore_for_file: file_names

class Item {
  final int id; // ID na lista
  final int cod;
  final String nameProd;
  final int qtP; // pallet
  final int qtL; // lastros
  final int qtC; // caixas
  final int qtU; // unidades
  final String validade; // Data

  const Item({
    required this.id, // ID na lista
    required this.cod,
    required this.nameProd,
    required this.qtP, // pallet
    required this.qtL, // lastros
    required this.qtC, // caixas
    required this.qtU, // unidades
    required this.validade, // data
  });

  // Convert a Dog into a Map. The keys must correspond to the names of the
  // columns in the database.
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'cod': cod,
      'name': nameProd,
      'qtP': qtP,
      'qtL': qtL,
      'qtC': qtC,
      'qtU': qtU,
      'validade': validade,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Pesquisa{id: $id, nameProd: $nameProd, PLCU: $qtP/$qtL/$qtC/$qtU, Data: $validade }';
  }
}
