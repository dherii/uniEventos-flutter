class Evento {
  final int id;
  final String titulo;
  final DateTime data;
  final String local;
  final String descricao;
  final String imagemUrl;
  final String categoria;

  const Evento({
    required this.id,
    required this.titulo,
    required this.data,
    required this.local,
    required this.descricao,
    required this.imagemUrl,
    required this.categoria,
  });

  factory Evento.fromMap(Map<String, dynamic> map) {
    return Evento(
      id: map['id'] as int,
      titulo: map['titulo'] as String,
      data: DateTime.parse(map['data'] as String),
      local: map['local'] as String,
      descricao: map['descricao'] as String,
      imagemUrl: map['imagemUrl'] as String,
      categoria: map['categoria'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'titulo': titulo,
      'data': data.toIso8601String(),
      'local': local,
      'descricao': descricao,
      'imagemUrl': imagemUrl,
      'categoria': categoria,
    };
  }
}
