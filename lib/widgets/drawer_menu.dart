import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  const DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).backgroundColor,
      child: Column(
        children: <Widget>[
          Container(
            color: Theme.of(context).primaryColor,
            child: const DrawerHeader(
              child: Center(child: Text('Categories')),
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Lights'),
              onTap: () {
                Navigator.of(context).pushNamed('/');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Plugs'),
              onTap: () {
                Navigator.of(context).pushNamed('/plugs');
              },
            ),
          ),
          Card(
            child: ListTile(
              title: const Text('Dimmers'),
              onTap: () {
                Navigator.of(context).pushNamed('/dimmers');
              },
            ),
          ),
        ],
      ),
    );
  }
}
