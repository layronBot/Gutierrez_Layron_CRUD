import 'package:flutter/material.dart';
import 'package:crud_flutter/paginas/pagina_lista.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      home: ListPages(),
    );
  }
}