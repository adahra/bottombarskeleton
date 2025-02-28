import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_bottom_nav/providers/counter_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final counter = Provider.of<CounterProvider>(context);

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Counter: ${counter.count}", style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: counter.increment, child: Text("Tambah")),
          ],
        ),
      ),
    );
  }
}
