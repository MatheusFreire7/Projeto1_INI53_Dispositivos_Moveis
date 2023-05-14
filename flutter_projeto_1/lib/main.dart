import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'horarioMonitor.dart';
import 'monitor.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Monitores DPD',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        '/details': (context) => DetailsPage(),
      },
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Monitor> monitors = [];

  @override
  void initState() {
    super.initState();
    getMonitors();
  }

  Future<void> getMonitors() async {
    final response =
        await http.get(Uri.parse('http://localhost:3000/api/monitor/get'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<Monitor> fetchedMonitors = [];
      for (var monitorData in data) {
        Monitor monitor = Monitor(
          id: monitorData['id'],
          nome: monitorData['nome'],
          avatar: monitorData['avatar'],
          email: monitorData['email'],
          horarios: HorarioMonitor(nome: '', horarios: {}),
        );
        fetchedMonitors.add(monitor);
      }
      setState(() {
        monitors = fetchedMonitors;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Monitores DPD'),
      ),
      body: ListView.builder(
        itemCount: monitors.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: AssetImage(monitors[index].avatar),
            ),
            title: Text(monitors[index].nome),
            subtitle: Text(monitors[index].email),
            onTap: () {
              Navigator.pushNamed(
                context,
                '/details',
                arguments: monitors[index],
              );
            },
          );
        },
      ),
    );
  }
}

class DetailsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Monitor monitor =
        ModalRoute.of(context)!.settings.arguments as Monitor;

    if (monitor == null) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Erro'),
        ),
        body: Center(
          child: Text('Monitor não encontrado'),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Monitor'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Nome: ${monitor.nome}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          FutureBuilder<HorarioMonitor>(
            future: getHorarios(monitor.nome),
            builder:
                (BuildContext context, AsyncSnapshot<HorarioMonitor> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Erro ao carregar horários do monitor');
              } else {
                final horariosMonitor = snapshot.data;
                return Column(
                  children: horariosMonitor!.horarios.entries.map((entry) {
                    final diaSemana = entry.key;
                    final horariosDia = entry.value;

                    return Column(
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Horário da Semana - $diaSemana:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Wrap(
                          spacing: 10.0,
                          runSpacing: 10.0,
                          children: horariosDia.entries.map((horarioEntry) {
                            final horario = horarioEntry.key;
                            final detalhes = horarioEntry.value;
                            final comeco =
                                detalhes['comeco'] ?? 'Não informado';
                            final local = detalhes['local'] ?? 'Não informado';
                            final termino =
                                detalhes['termino'] ?? 'Não informado';
                            return Container(
                              width: MediaQuery.of(context).size.width *
                                  0.45, // Adjust the width as needed
                              child: Card(
                                child: ListTile(
                                  title: Text(horario),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Início: $comeco'),
                                      Text('Local: $local'),
                                      Text('Término: $termino'),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    );
                  }).toList(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

Future<HorarioMonitor> getHorarios(String nome) async {
  final response = await http
      .get(Uri.parse('http://localhost:3000/api/monitor/horarios/$nome'));

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);

    if (data is Map<String, dynamic>) {
      Map<String, dynamic> horariosData = data;
      HorarioMonitor horarios = HorarioMonitor(nome: nome, horarios: {});

      horariosData.forEach((diaSemana, horariosDia) {
        if (horariosDia is Map<String, dynamic>) {
          Map<String, dynamic> horariosDiaMap = horariosDia;
          Map<String, Map<String, String>> horariosDiaMapConverted = {};

          horariosDiaMap.forEach((horario, detalhes) {
            if (detalhes is Map<String, dynamic>) {
              Map<String, dynamic> detalhesMap = detalhes;
              if (horario is String && detalhesMap is Map<String, dynamic>) {
                horariosDiaMapConverted[horario] = detalhesMap
                    .map((key, value) => MapEntry(key, value.toString()));
              }
            }
          });

          horarios.horarios[diaSemana] = horariosDiaMapConverted;
        }
      });

      return horarios;
    }
  }

  return HorarioMonitor(nome: '', horarios: {});
}
