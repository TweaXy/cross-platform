import 'package:crypto/crypto.dart';
import 'dart:convert';

class Utils {
  String hashText(String text) {
    // Convert the text to a list of bytes using utf8 encoder
    List<int> bytes = utf8.encode(text);
    // Compute the SHA-256 hash of the bytes
    Digest digest = sha256.convert(bytes);
    // Return the hash as a hexadecimal string
    return digest.toString().substring(0, 10);
  }
}
