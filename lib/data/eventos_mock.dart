import '../models/evento.dart';

/// Gera um mock de 50 eventos acadêmicos usando List.generate
List<Evento> gerarEventosMock() {
  const categorias = [
    'Palestra',
    'Workshop',
    'Hackathon',
    'Seminário',
    'Conferência',
  ];

  const titulos = [
    'Introdução à Inteligência Artificial',
    'Flutter do Zero ao Avançado',
    'Hackathon de Inovação Social',
    'Segurança em Aplicações Web',
    'DevOps na Prática',
    'Machine Learning com Python',
    'UX/UI Design para Desenvolvedores',
    'Blockchain e Web3',
    'Clean Code e Boas Práticas',
    'Arquitetura de Microsserviços',
  ];

  const locais = [
    'Auditório Principal — Bloco A',
    'Lab de Informática 01',
    'Sala de Inovação — Bloco C',
    'Auditório da Engenharia',
    'Centro de Convenções',
  ];

  const descricoes = [
    'Uma imersão completa nos conceitos fundamentais e nas tendências do mercado, '
        'com cases reais e espaço para networking com profissionais da área.',
    'Hands-on intensivo com exercícios práticos, projetos guiados e mentoria '
        'individual dos instrutores especializados.',
    'Desafio de 24h para criar soluções inovadoras com impacto real na comunidade, '
        'com premiação e oportunidades de incubação.',
    'Debate aprofundado sobre o estado da arte, pesquisas recentes e caminhos '
        'para a próxima geração de tecnologias.',
  ];

  const imageIds = [
    '1540575467537-b54f54c3e7e8',
    '1517245386807-bb43f82c33c4',
    '1531482615713-2afd69097998',
    '1504384308090-c894fdcc538d',
    '1519389950473-47ba0277781c',
    '1522071820081-009f0129c71c',
    '1531498860502-7c67cf519b9e',
    '1543269865-cbf427effbad',
    '1491975474562-1f4e30bc9468',
    '1516321318423-f06f85e504b3',
  ];

  return List.generate(50, (index) {
    final categoriaIndex = index % categorias.length;
    final tituloBase = titulos[index % titulos.length];
    final edicao = (index ~/ titulos.length) + 1;

    return Evento(
      id: index + 1,
      titulo: edicao > 1 ? '$tituloBase — Edição $edicao' : tituloBase,
      data: DateTime.now().add(Duration(days: (index * 3) + 1)),
      local: locais[index % locais.length],
      descricao: descricoes[index % descricoes.length],
      imagemUrl:
          'https://images.unsplash.com/photo-${imageIds[index % imageIds.length]}'
          '?w=600&q=80',
      categoria: categorias[categoriaIndex],
    );
  });
}
