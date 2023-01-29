
import 'package:flutter/material.dart';
import 'package:gugu/pages/history.dart';
import 'package:gugu/pages/promotions.dart';
import 'package:gugu/pages/settings.dart';


class NavDrawer extends StatefulWidget {
  const NavDrawer({super.key});

  @override
  State<NavDrawer> createState() => _NavDrawer();

}

class _NavDrawer extends State<NavDrawer> {

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
                color: Colors.blueGrey,
                image: DecorationImage(
                  image: AssetImage('assets/images/user.png'
                  ),
                )
            ), child: null,

          ),
          ListTile(
            title: const Text('Profile'),
            onTap: () => {
              // _openSpin(context)
            },
          ),
          ListTile(
            title: const Text('Promotion'),
            onTap: () => { _purchaseHistory(context)},
          ),
          ListTile(
            title: const Text('Purchase History'),
            onTap: () => { _promo(context)},
          ),
          ListTile(
            title: const Text("Settings"),
            onTap: () => { _settings(context)},
          ),
          ListTile(
            title: const Text("My Shopping Cart"),
            onTap: () => { _myShoppingCart(context)},
          ),
          ListTile(
            title: Text('Report fraud'),
            onTap: () => { _reportFraud(context)},
          )
        ],
      ),
    );
  }

  _promo(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Promotions())
    );
  }

  _purchaseHistory(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const PurchaseHistory())
    );
  }

  _settings(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Settings())
    );
  }

  _myShoppingCart(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Settings())
    );
  }

  _reportFraud(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => const Settings())
    );
  }
}

