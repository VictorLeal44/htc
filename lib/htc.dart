import 'dart:io';

dynamic cargar(String path) {
  final archivo = File(
    '$path/.bash_history',
  ); // crees que colocare mi path directa, no para eso esta dartIO
  try {
    // necesito una lista para que sea facil de procesar
    List contenido = archivo.readAsLinesSync();
    print(contenido);
    return contenido; // nos vemos
  } catch (e) {
    print('Error al leer el archivo: $e');
  }
}

dynamic recapitular(List contenido) {
  List<String> comandos = [];
  for (int i = contenido.length - 1; i >= 0; i--) {
    // iteraremos pero en reversa para que los ultimos comandos ejecutados se queden y se borren los primeros del historial
    String linea = contenido[i];
    // escribir contenido[i] cada rato me molesta entiendame

    if (linea.isEmpty) {
      // no deberia existir campos vacios
      contenido.removeAt(i);
      continue;
    }

    if (linea.startsWith('#') ||
        linea.startsWith('//') ||
        linea.startsWith('```') ||
        linea.startsWith('\$') || // si haces consulta con terminal esto deberia mitigar los comentarios post tramposo
        linea.startsWith('>')) {
      print('Comentario detectado, será eliminado: $linea');
      contenido.removeAt(i);
    } else if (comandos.contains(linea)) {
      print('Existe, por lo que se deberá eliminar: $linea'); // no queremos repetir comandos asi sera facil buscar o eso creo por algo hago este programa
      contenido.removeAt(i);
    } else {
      comandos.add(linea);
      print('No existe: se inserta $linea'); // necesitamos el contenido de la lista para identificar que se repite solo se aplica la primera vez
    }
  }
  for (String i in contenido) {
    print(i); // miremos resultados, no se porque dejo esto si lo dejare para que se ejecute cuando enciende la laptop
  }
  return contenido;
}

dynamic guardar(List contenido, String path) {
  final archivo = File('$path/.bash_history');
  try {
    // Une los elementos con un salto de línea y los escribe de golpe
    archivo.writeAsStringSync(contenido.join('\n'));
    print('Guardado correctamente.');
  } catch (e) {
    print('Error: $e');
  }
}
