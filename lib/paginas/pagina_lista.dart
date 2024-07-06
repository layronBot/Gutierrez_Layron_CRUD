import 'package:flutter/material.dart';
import 'package:crud_flutter/db/operaciones.dart';
import 'package:crud_flutter/paginas/guardar_pagina.dart';
import 'package:crud_flutter/modelos/notas.dart';

class ListPages extends StatefulWidget {
  const ListPages({super.key});

  @override
  _ListPagesState createState() => _ListPagesState();
}

class _ListPagesState extends State<ListPages> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          final resultado = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => GuardarPagina()),
          );
          if (resultado != null && resultado) {
            setState(() {});
          }
        },
      ),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: const Text('CRUD de notas', style: TextStyle(color: Colors.white)),
      ),
      body: Container(
        child: _MiLista(),
      ),
    );
  }
}

class _MiLista extends StatefulWidget {
  @override
  State<_MiLista> createState() => _MiListaState();
}

class _MiListaState extends State<_MiLista> {
  List<Nota> notas = [];

  @override
  void initState() {
    super.initState();
    _cargarDatos();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: notas.length,
      itemBuilder: (_, i) => _crearTEm(i),
    );
  }

  _cargarDatos() async {
    List<Nota> auxNotas = await Operaciones.obtenerNotas();
    setState(() {
      notas = auxNotas;
    });
  }

  _crearTEm(int i) {
    return Dismissible(
      key: Key(i.toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        padding: const EdgeInsets.only(left: 10),
        color: Colors.red,
        child: const Align(
          alignment: Alignment.centerLeft,
          child: Icon(Icons.delete, color: Colors.white, size: 30),
        ),
      ),
      onDismissed: (direction) {
        Operaciones.eliminarOperacion(notas[i]);
        setState(() {
          notas.removeAt(i);
        });
      },
      child: ListTile(
        title: Text(notas[i].titulo),
        subtitle: Text(notas[i].descripcion),
        trailing: IconButton(
          icon: Icon(Icons.edit),
          onPressed: () async {
            final resultado = await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => GuardarPagina(
                  nota: notas[i],
                ),
              ),
            );
            if (resultado != null && resultado) {
              _cargarDatos();
            }
          },
        ),
      ),
    );
  }
}