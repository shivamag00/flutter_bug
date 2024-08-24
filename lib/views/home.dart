import 'package:flutter/material.dart';
import 'package:wallet/resources/style_constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {

  Future<bool?> _showBackDialog() {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout ?'),
          content: const Text(
            'Are you sure you want to logout ?',
          ),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.pop(context, false);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Logout'),
              onPressed: () {
                Navigator.pop(context, true);
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final bool shouldPop = await _showBackDialog() ?? false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: SpeedDial(
          icon: Icons.add,
          activeIcon: Icons.close,
          spacing: 9,
          children: [
            SpeedDialChild(
              child: const Icon(Icons.credit_card),
              label: "Add a card"
            ),
            SpeedDialChild(
                child: const Icon(Icons.account_balance),
                label: "Add a Bank/Issuing Authority",
                onTap: () => Navigator.pushNamed(context, '/create_ia')
            )
          ],
        ),
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                child: Text("Home Page"),
              ),
            ],
          ),
        ), // This trailing comma makes auto-formatting nicer for build methods.
      )
    );
  }
}
