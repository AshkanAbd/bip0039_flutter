import 'package:bip39/bip0039/mnemonic.dart';
import 'package:bip39/bip0039/utils.dart';
import 'package:flutter_test/flutter_test.dart';
import 'dart:convert';
import 'dart:io';

void main() async {
  test('EN vectors', () async {
    var items = await readJsonFile('./test/vectors_EN_BIP39.json');

    for (var item in items) {
      var mnemonic = await Mnemonic.fromEntropy(fromHex(item['entropy']));

      expect(mnemonic.getPhrases(), item['mnemonic']);
      var seed = await mnemonic.getSeed(passphrase: item['passphrase']);
      expect(toHex(seed), item['seed']);

      var mnemonic1 = await Mnemonic.fromPhrase(mnemonic.getPhrases());
      expect(toHex(mnemonic1.getEntropy()), item['entropy']);
      var seed1 = await mnemonic1.getSeed(passphrase: item['passphrase']);
      expect(toHex(seed1), item['seed']);
      expect(toHex(seed), toHex(seed1));
    }
  });
}

Future<List<dynamic>> readJsonFile(String filePath) async {
  var input = await File(filePath).readAsString();
  return jsonDecode(input);
}
