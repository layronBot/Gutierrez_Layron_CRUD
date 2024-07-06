import 'package:crud_flutter/db/operaciones.dart';
import 'package:crud_flutter/modelos/notas.dart';
import 'package:flutter/material.dart';

class GuardarPagina extends StatelessWidget {
  final Nota? nota;

  const GuardarPagina({super.key, this.nota});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(nota == null ? 'Añadir Nueva Nota' : 'Editar Nota'),
      ),
      body: GuardarFormulario(nota: nota),
    );
  }
}

class GuardarFormulario extends StatefulWidget {
  final Nota? nota;

  const GuardarFormulario({super.key, this.nota});

  @override
  State<GuardarFormulario> createState() => _GuardarFormularioState();
}

class _GuardarFormularioState extends State<GuardarFormulario> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descripcionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.nota != null) {
      _tituloController.text = widget.nota!.titulo;
      _descripcionController.text = widget.nota!.descripcion;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _tituloController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingresa el titulo de la nota';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Añade aquí el titulo de la nota',
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _descripcionController,
              maxLength: 1000,
              maxLines: 4,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Ingresa la descripción de la nota';
                }
                return null;
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Añade aquí la descripcion de la nota',
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              child: Text(widget.nota == null ? 'Añadir Nota' : 'Actualizar Nota'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (widget.nota == null) {
                    Operaciones.insertarOperacion(
                      Nota(
                        titulo: _tituloController.text,
                        descripcion: _descripcionController.text,
                      ),
                    );
                  } else {
                    Operaciones.actualizarOperacion(
                      Nota(
                        id: widget.nota!.id,
                        titulo: _tituloController.text,
                        descripcion: _descripcionController.text,
                      ),
                    );
                  }
                  Navigator.pop(context, true);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}