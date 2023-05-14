import 'package:flutter/material.dart';
import 'horarioMonitor.dart';

class Monitor {
  final String id;
  final String nome;
  final String avatar;
  final String email;
  final HorarioMonitor horarios; // Adicione esta linha

  Monitor(
      {required this.id,
      required this.nome,
      required this.avatar,
      required this.email,
      required this.horarios}); // Atualize o construtor
}