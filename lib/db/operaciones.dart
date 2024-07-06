import 'package:sqflite/sqflite.dart';
import 'package:crud_flutter/modelos/notas.dart';
import 'package:path/path.dart';

class Operaciones {
  static Future<Database> _openDB() async {
    try {
      return await openDatabase(
        join(await getDatabasesPath(), 'notas.db'),
        onCreate: (db, version) {
          return db.execute(
            "CREATE TABLE IF NOT EXISTS notas(id INTEGER PRIMARY KEY, titulo TEXT, descripcion TEXT)",
          );
        },
        version: 1,
      );
    } catch (e) {
      print('Error al abrir la base de datos: $e');
      throw Exception('Error al abrir la base de datos');
    }
  }

  static Future<void> insertarOperacion(Nota nota) async {
    Database db = await _openDB();
    db.insert('notas', nota.toMap());
  }

  static Future<void> eliminarOperacion(Nota nota) async {
    Database db = await _openDB();
    db.delete('notas', where: 'id = ?', whereArgs: [nota.id]);
  }

  static Future<void> actualizarOperacion(Nota nota) async {
    Database db = await _openDB();
    db.update('notas', nota.toMap(), where: 'id = ?', whereArgs: [nota.id]);
  }

  static Future<List<Nota>> obtenerNotas() async {
    Database db = await _openDB();
    final List<Map<String, dynamic>> notasMaps = await db.query('notas');

    for (var n in notasMaps) {
      print("____" + n['titulo'].toString());
      print("____" + n['descripcion'].toString());
    }

    return List.generate(notasMaps.length, (i) {
      return Nota(
        id: notasMaps[i]['id'],
        titulo: notasMaps[i]['titulo'],
        descripcion: notasMaps[i]['descripcion'],
      );
    });
  }
}