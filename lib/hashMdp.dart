import 'dart:convert';
import 'package:crypto/crypto.dart';

String hashPassword(String password) {
  // Convertir le mot de passe en bytes
  var bytes = utf8.encode(password);

  // Hacher les bytes avec SHA256
  var digest = sha256.convert(bytes);

  // Convertir le hash en une chaîne hexadécimale
  return digest.toString();
}
