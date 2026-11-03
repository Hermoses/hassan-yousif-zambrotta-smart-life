import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

class Plugs extends StatefulWidget {
  const Plugs({super.key});

  @override
  State<Plugs> createState() => _PlugsState();
}

class _PlugsState extends State<Plugs> {
  final List myList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('Plugs'),
      ),
      body: Center(
        child: myList.isNotEmpty
            ? ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return (_buildlist(myList[index]));
                },
              )
            : const Card(
                child: Text(
                  'no device found',
                  style: TextStyle(fontSize: 40),
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildlist(widget) {
    return Card(
      child: Row(
        children: [
          const Text('device number'),
          ElevatedButton(
              onPressed: () {
                print('pressed');
              },
              child: const Icon(Icons.add))
        ],
      ),
    );
  }
}
