import 'package:flutter/material.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("App Bar"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            const Text("Text body"),
            ElevatedButton(
              onPressed: () => {},
              child: const Text(
                "Click Me",
              ),
            )
          ],
        ),
      ),
    );
  }
}
