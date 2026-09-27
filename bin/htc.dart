import 'dart:io';

import 'package:htc/htc.dart' as htc;

void main(List<String> arguments) {
  late String pathHistorial = Platform.environment["HOME"] ?? '';

  // podria haber escrito todo aquí pero no queria dejar lib vacío
  late List contenido = htc.cargar(pathHistorial);
  late List contenidoProcesado = htc.recapitular(contenido);
  htc.guardar(contenidoProcesado, pathHistorial);
}
