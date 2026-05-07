import 'package:flutter/material.dart';
import '../data/eventos_mock.dart';
import '../models/evento.dart';
import '../routes/app_routes.dart';
import '../theme/app_theme.dart';
import '../widgets/evento_card.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  final List<Evento> _todosEventos = gerarEventosMock();
  List<Evento> _eventosFiltrados = [];
  final TextEditingController _buscaController = TextEditingController();
  String _categoriaSelecionada = 'Todos';

  static const _categorias = [
    'Todos',
    'Palestra',
    'Workshop',
    'Hackathon',
    'Seminário',
    'Conferência',
  ];

  @override
  void initState() {
    super.initState();
    _eventosFiltrados = _todosEventos;
    _buscaController.addListener(_filtrar);
  }

  @override
  void dispose() {
    _buscaController.dispose();
    super.dispose();
  }

  void _filtrar() {
    final query = _buscaController.text.toLowerCase();
    setState(() {
      _eventosFiltrados = _todosEventos.where((e) {
        final matchCategoria = _categoriaSelecionada == 'Todos' ||
            e.categoria == _categoriaSelecionada;
        final matchBusca = query.isEmpty ||
            e.titulo.toLowerCase().contains(query) ||
            e.local.toLowerCase().contains(query);
        return matchCategoria && matchBusca;
      }).toList();
    });
  }

  void _selecionarCategoria(String categoria) {
    setState(() => _categoriaSelecionada = categoria);
    _filtrar();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Image.asset(
          'assets/images/UnicatolicaLogoWhite.png',
          height: 32,
          fit: BoxFit.contain,
        ),
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: AppColors.gradienteInstitucional,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Row(
              children: [
                const Icon(
                  Icons.event_available,
                  size: 18,
                  color: Colors.white,
                ),
                const SizedBox(width: 6),
                Text(
                  '${_eventosFiltrados.length} eventos',
                  style: const TextStyle(color: Colors.white, fontSize: 13),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFiltrosCategorias(),
          Expanded(child: _buildLista()),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppColors.gradienteInstitucional,
      ),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: TextField(
        controller: _buscaController,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: 'Buscar eventos...',
          hintStyle: TextStyle(color: Colors.white.withOpacity(0.9)),
          prefixIcon: Icon(Icons.search, color: Colors.white.withOpacity(0.9)),
          suffixIcon: _buscaController.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white70),
                  onPressed: () => _buscaController.clear(),
                )
              : null,
          filled: true,
          fillColor: Colors.white.withOpacity(0.2),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.white.withOpacity(0.5)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.white),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
        ),
      ),
    );
  }

  Widget _buildFiltrosCategorias() {
    return Container(
      height: 44,
      color: Colors.white,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: _categorias.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final cat = _categorias[index];
          final selecionada = cat == _categoriaSelecionada;
          return GestureDetector(
            onTap: () => _selecionarCategoria(cat),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14),
              decoration: BoxDecoration(
                color: selecionada ? AppColors.primaria : AppColors.superficie,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: selecionada
                      ? AppColors.primaria
                      : const Color(0xFFD1D5DB),
                ),
              ),
              child: Center(
                child: Text(
                  cat,
                  style: TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: selecionada ? Colors.white : AppColors.textoSuave,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildLista() {
    if (_eventosFiltrados.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64,
              color: AppColors.textoSuave.withOpacity(0.4),
            ),
            const SizedBox(height: 16),
            const Text(
              'Nenhum evento encontrado',
              style: TextStyle(color: AppColors.textoSuave, fontSize: 16),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: _eventosFiltrados.length,
      itemBuilder: (context, index) {
        final evento = _eventosFiltrados[index];
        return EventoCard(
          evento: evento,
          onTap: () => Navigator.pushNamed(
            context,
            AppRoutes.detalhes,
            arguments: evento,
          ),
        );
      },
    );
  }
}
