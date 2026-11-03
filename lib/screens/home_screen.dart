import 'package:flutter/material.dart';
import '../widgets/drawer_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List myList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const DrawerMenu(),
      appBar: AppBar(
        title: const Text('LIGHTS'),
      ),
      body: Center(
        child: myList.isNotEmpty
            ? ListView.builder(
                itemCount: myList.length,
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
        onPressed: () {
          print(myList.length);

          setState(() {
            myList.add(_buildlist);
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildlist(context) {
    int index = myList.lastIndexOf(_buildlist);
    int length = myList.length;
    return ListTile(
      onLongPress: () {
        setState(() {
          myList.removeAt(index);
        });
      },
      title: Card(
        child: Column(
          children: [
            Text('device number $length'),
            ElevatedButton(
                onPressed: () {
                  print(index);
                },
                child: const Icon(Icons.add))
          ],
        ),
      ),
    );
  }
}
