import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          const DrawerHeader(
            child: Text('App Drawer'),
          ),
          ListTile(
            title: const Text('Products'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/');
            },
          ),
          ListTile(
            title: const Text('Orders'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed('/order-screen');
            },
          ),
        ],
      ),
    );
  }
}
