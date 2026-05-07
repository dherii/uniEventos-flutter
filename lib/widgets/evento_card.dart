// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import '../models/evento.dart';
import '../theme/app_theme.dart';

class EventoCard extends StatefulWidget {
  final Evento evento;
  final VoidCallback onTap;

  const EventoCard({super.key, required this.evento, required this.onTap});

  @override
  State<EventoCard> createState() => _EventoCardState();
}

class _EventoCardState extends State<EventoCard> {
  bool _favoritado = false;

  void _toggleFavorito() {
    setState(() {
      _favoritado = !_favoritado;
    });
  }

  String get _dataFormatada {
    final d = widget.evento.data;
    const meses = [
      'jan',
      'fev',
      'mar',
      'abr',
      'mai',
      'jun',
      'jul',
      'ago',
      'set',
      'out',
      'nov',
      'dez',
    ];
    return '${d.day.toString().padLeft(2, '0')} ${meses[d.month - 1]} ${d.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      child: InkWell(
        onTap: widget.onTap,
        child: ListTile(
          contentPadding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
          leading: _buildAvatar(),
          title: Text(
            widget.evento.titulo,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.5,
              color: AppColors.texto,
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildChip(widget.evento.categoria),
                const SizedBox(height: 4),
                _buildInfoRow(Icons.calendar_today_outlined, _dataFormatada),
                const SizedBox(height: 2),
                _buildInfoRow(Icons.location_on_outlined, widget.evento.local),
              ],
            ),
          ),
          trailing: _buildFavoritoButton(),
          isThreeLine: true,
        ),
      ),
    );
  }

  Widget _buildAvatar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: Image.network(
        widget.evento.imagemUrl,
        width: 56,
        height: 56,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => Container(
          width: 56,
          height: 56,
          color: AppColors.primaria.withOpacity(0.1),
          child: const Icon(Icons.event, color: AppColors.primaria),
        ),
        loadingBuilder: (_, child, progress) {
          if (progress == null) return child;
          return Container(
            width: 56,
            height: 56,
            color: AppColors.superficie,
            child: const Center(
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primaria.withOpacity(0.12),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 11,
          color: AppColors.primaria,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: AppColors.textoSuave),
        const SizedBox(width: 4),
        Expanded(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, color: AppColors.textoSuave),
          ),
        ),
      ],
    );
  }

  Widget _buildFavoritoButton() {
    return IconButton(
      onPressed: _toggleFavorito,
      tooltip: _favoritado ? 'Remover dos favoritos' : 'Favoritar',
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 250),
        transitionBuilder: (child, animation) =>
            ScaleTransition(scale: animation, child: child),
        child: Icon(
          _favoritado ? Icons.favorite : Icons.favorite_border,
          key: ValueKey(_favoritado),
          color: _favoritado ? AppColors.favorito : AppColors.textoSuave,
        ),
      ),
    );
  }
}
