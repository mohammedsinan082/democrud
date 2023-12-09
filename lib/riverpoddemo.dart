import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final countProvider=StateProvider<int>((ref) => 0 );



class Riverpoddemo extends ConsumerWidget {
  const Riverpoddemo({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
    int count=ref.watch(countProvider);
    print(count);
    return Scaffold(
      appBar: AppBar(),
      body:Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("$count"),
             
            ],
          ),
          ElevatedButton(
              onPressed: () {
                ref.read(countProvider.notifier).state++;
              },
              child: Text("Click"))
        ],
      ),
    );
  }
}
