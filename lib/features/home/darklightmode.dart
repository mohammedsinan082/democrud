import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final themeProvider=StateProvider<bool>((ref) => true);

class darklightmode extends ConsumerWidget {
  const darklightmode({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    return const Scaffold(

    );
  }
}
