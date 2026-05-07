import 'package:flutter/material.dart';
import '../models/evento.dart';
import '../theme/app_theme.dart';

class TelaDetalhes extends StatefulWidget {
  const TelaDetalhes({super.key});

  @override
  State<TelaDetalhes> createState() => _TelaDetalhesState();
}

class _TelaDetalhesState extends State<TelaDetalhes> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool _inscrito = false;
  bool _enviando = false;

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  String get _dataFormatada {
    final evento = _getEvento();
    if (evento == null) return '';
    final d = evento.data;
    const meses = [
      'Janeiro',
      'Fevereiro',
      'Março',
      'Abril',
      'Maio',
      'Junho',
      'Julho',
      'Agosto',
      'Setembro',
      'Outubro',
      'Novembro',
      'Dezembro',
    ];
    return '${d.day.toString().padLeft(2, '0')} de ${meses[d.month - 1]} de ${d.year}';
  }

  Evento? _getEvento() {
    return ModalRoute.of(context)?.settings.arguments as Evento?;
  }

  Future<void> _enviarInscricao() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;

    setState(() => _enviando = true);

    await Future.delayed(const Duration(milliseconds: 250));

    setState(() {
      _enviando = false;
      _inscrito = true;
    });

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.white),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Inscrição confirmada, ${_nomeController.text.trim().split(' ').first}! 🎉',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
        backgroundColor: AppColors.secundaria,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final evento = _getEvento();

    if (evento == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Detalhes')),
        body: const Center(child: Text('Evento não encontrado.')),
      );
    }

    return Scaffold(
      backgroundColor: AppColors.superficie,
      body: CustomScrollView(
        slivers: [
          _buildAppBar(evento),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoCard(evento),
                  const SizedBox(height: 20),
                  _buildDescricao(evento),
                  const SizedBox(height: 24),
                  _buildFormulario(evento),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(Evento evento) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          evento.titulo,
          maxLines: 2,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
        ),
        background: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              evento.imagemUrl,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.gradienteInstitucional,
                ),
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Color(0xCC013857)],
                  stops: [0.35, 1.0],
                ),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: AppColors.secundaria,
      foregroundColor: Colors.white,
    );
  }

  Widget _buildInfoCard(Evento evento) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildInfoRow(Icons.calendar_today, 'Data', _dataFormatada),
            const Divider(height: 20),
            _buildInfoRow(Icons.location_on, 'Local', evento.local),
            const Divider(height: 20),
            _buildInfoRow(Icons.category, 'Categoria', evento.categoria),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String valor) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.primaria.withOpacity(0.08),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: AppColors.primaria, size: 20),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textoSuave,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                valor,
                style: const TextStyle(
                  fontSize: 14.5,
                  color: AppColors.texto,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDescricao(Evento evento) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Sobre o evento',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.texto,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          evento.descricao,
          style: const TextStyle(
            fontSize: 14.5,
            color: AppColors.textoSuave,
            height: 1.6,
          ),
        ),
      ],
    );
  }

  Widget _buildFormulario(Evento evento) {
    if (_inscrito) return _buildInscritoConfirmacao();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Inscrição',
          style: TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.texto,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Preencha os dados para garantir sua vaga em "${evento.titulo}".',
          style: const TextStyle(fontSize: 13, color: AppColors.textoSuave),
        ),
        const SizedBox(height: 16),

        Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nomeController,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Nome completo',
                  prefixIcon: Icon(Icons.person_outline),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe seu nome.';
                  }
                  if (value.trim().length < 3) {
                    return 'Nome deve ter ao menos 3 caracteres.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 14),

              TextFormField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(
                  labelText: 'E-mail',
                  prefixIcon: Icon(Icons.email_outlined),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Por favor, informe seu e-mail.';
                  }
                  if (!value.contains('@')) {
                    return 'E-mail inválido. O e-mail deve conter "@".';
                  }
                  final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
                  if (!emailRegex.hasMatch(value.trim())) {
                    return 'Formato de e-mail inválido.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _enviando ? null : _enviarInscricao,
                  child: _enviando
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.how_to_reg),
                            SizedBox(width: 8),
                            Text('Confirmar Inscrição'),
                          ],
                        ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildInscritoConfirmacao() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secundaria.withOpacity(0.08),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secundaria.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: AppColors.secundaria.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.check_circle,
              color: AppColors.secundaria,
              size: 36,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Inscrição realizada!',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.secundaria,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            'Olá, ${_nomeController.text.trim().split(' ').first}! Sua inscrição foi confirmada. '
            'Fique atento ao seu e-mail ${_emailController.text.trim()} para mais informações.',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 13.5,
              color: AppColors.textoSuave,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
