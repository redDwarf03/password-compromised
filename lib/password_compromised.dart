library password_compromised;

import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart' as crypto;
import 'dart:convert';

/// Checks if password is compromised
Future isPasswordCompromised(String password) async {
  if (password.isEmpty) throw Exception('You must provide a password');

  final digest =
      crypto.sha1.convert(utf8.encode(password)).toString().toUpperCase();
  final firstFive = digest.substring(0, 5);

  final response = await http
      .read(Uri.parse('https://api.pwnedpasswords.com/range/$firstFive'));

  return response
      .split('\r\n')
      .any((o) => firstFive + o.split(':')[0] == digest);
}
