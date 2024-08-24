import 'package:flutter/material.dart';
import 'package:wallet/resources/style_constants.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class CreateIAPage extends StatefulWidget {
  const CreateIAPage({super.key, required this.title});

  final String title;

  @override
  State<CreateIAPage> createState() => _CreateIAPage();
}

class _CreateIAPage extends State<CreateIAPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
            label: "Add a bank"
          ),
          SpeedDialChild(
              child: const Icon(Icons.account_balance),
              label: "Add a Bank/Issuing Authority",
              onTap: () => Navigator.pushNamed(context, '/home')
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
              child: Text("Create IA"),
              ),
            ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
