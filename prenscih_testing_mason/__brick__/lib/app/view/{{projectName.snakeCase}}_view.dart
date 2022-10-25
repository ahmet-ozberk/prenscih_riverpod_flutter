import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:grock/grock.dart';

class {{projectName.pascalCase()}}View extends ConsumerStatefulWidget {
  const {{projectName.pascalCase()}}View({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _{{projectName.pascalCase()}}ViewState();
}

class _{{projectName.pascalCase()}}ViewState extends ConsumerState<{{projectName.pascalCase()}}View> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('{{projectName.pascalCase()}}')),
      body: Container(),
    );
  }
}