import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/app_provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context){
    final username = context.watch<AppProvider>().username;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Hello, $username!', style: TextStyle(fontSize: 24)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              context.read<AppProvider>().updateUsername("Broklis");
            },
            child: Text("Change me"),
          )
        ],
      ),
    );
  }
}