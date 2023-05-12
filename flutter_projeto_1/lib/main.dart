import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() => runApp(MyApp());

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

class HorarioMonitor {
  final String nome;
  final Map<String, Map<String, Map<String, String>>> horarios;

  HorarioMonitor({required this.nome, required this.horarios});
}

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
    final Monitor monitor = ModalRoute.of(context)!.settings.arguments as Monitor;

    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Monitor'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            monitor.nome,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          FutureBuilder<void>(
            future: getHorarios(monitor.nome),
            builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                print(snapshot.error);
                return Text('Erro ao carregar horários do monitor');
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: monitor.horarios.horarios.length, // Acessando o comprimento do mapa de horários
                    itemBuilder: (context, index) {
                      String diaSemana = monitor.horarios.horarios.keys.toList()[index]; // Acessando as chaves do mapa de horários
                      Map<String, Map<String, String>> horariosDia = monitor.horarios.horarios[diaSemana]!;
                      return ListTile(
                        title: Text(diaSemana),
                        subtitle: Column(
                          children: horariosDia.entries.map((entry) {
                            String hora = entry.key;
                            String descricao = entry.value['descricao'] ?? '';
                            return ListTile(
                              title: Text(hora),
                              subtitle: Text(descricao),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Future<HorarioMonitor> getHorarios(String nome) async {
    final encodedNome = Uri.encodeComponent(nome); // Codifica o nome do monitor
    final response = await http.get(Uri.parse('http://localhost:3000/api/monitor/horarios/$encodedNome'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      HorarioMonitor horarioMonitor = HorarioMonitor(
        nome: nome,
        horarios: data,
      );
      return horarioMonitor;
    } else {
     
      throw Exception('Falha ao carregar horários do monitor');
    }
  }
}
