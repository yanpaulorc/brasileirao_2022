import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // List<Widget> card = List.generate(20, (index) => const TeamCard());

  final url = 'https://www.scorebat.com/api/competition/2/brasil-serie-a';
  var _list = [];
  var imageLink = 'https://s3.amazonaws.com/bookmkrs/img/logos/mini/';

  void teams() async {
    try {
      final response = await http.get(Uri.parse(url));
      final json = jsonDecode(response.body);
      Map<String, dynamic> dados = json;
      final mapCampeonato = dados['response']['standings']['rows'];
      _list = mapCampeonato;
      // for (var mapCampeonato in _list) {
      //   print('Time: ${mapCampeonato['team']}'
      //       ' Posição: ${mapCampeonato['row']}');
      // }
    } catch (e) {}
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    teams();
  }

  String titulo = 'Campeonato Brasileiro 2022';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(titulo), backgroundColor: Colors.green),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
            itemCount: _list.length,
            itemBuilder: (context, i) {
              final tabela = _list[i];
              return Card(
                child: ListTile(
                  trailing: Text(
                    '${tabela['pnt']}',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  title: Text(tabela['team']),
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child:
                        Image.network('${imageLink + tabela['teamScId']}.png'),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
