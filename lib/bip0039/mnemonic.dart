import 'dart:math';
import 'package:bip39/bip0039/utils.dart';
import 'package:bip39/bip0039/word_count.dart';
import 'package:bip39/bip0039/word_list.dart';
import 'package:cryptography/cryptography.dart';

class Mnemonic {
  List<String> _words = [];
  late final WordCount _wordCount;
  late final List<int> _entropy;
  late String _entropyBitArray;
  WordLang lang;

  static Future<Mnemonic> generate(WordCount wordCount, {WordLang lang = WordLang.En}) async {
    var mnemonic = Mnemonic._(wordCount, lang);

    var sha256 = Sha256();

    mnemonic._entropyBitArray = byteArrayToBitArray(mnemonic._entropy);

    mnemonic._entropyBitArray += mnemonic._getChecksumBitArray(wordCount, (await sha256.hash(mnemonic._entropy)).bytes);

    mnemonic._calculateWords();

    return mnemonic;
  }

  static Future<Mnemonic> fromEntropy(List<int> entropy, {WordLang lang = WordLang.En}) async {
    var mnemonic = Mnemonic._fromEntropy(entropy, lang);

    var sha256 = Sha256();

    mnemonic._entropyBitArray = byteArrayToBitArray(mnemonic._entropy);

    mnemonic._entropyBitArray +=
        mnemonic._getChecksumBitArray(mnemonic._wordCount, (await sha256.hash(mnemonic._entropy)).bytes);

    mnemonic._calculateWords();

    return mnemonic;
  }

  static Future<Mnemonic> fromPhrase(String phrase, {WordLang lang = WordLang.En}) async {
    var words = phrase.toLowerCase().split(" ");

    var wordList = getWordList(lang);
    var decimalEntropyWithChecksum = words.map((e) {
      var i = wordList!.indexOf(e);
      if (i == -1) throw 'Invalid word $e';
      return i;
    }).toList(growable: false);

    var entropyHex = byteArrayToBitArray(decimalEntropyWithChecksum, padding: 11);

    var entropy = <int>[];
    for (var i = 0; i + 8 < entropyHex.length; i += 8) {
      entropy.add(int.parse(entropyHex.substring(i, i + 8), radix: 2));
    }

    return Mnemonic.fromEntropy(entropy, lang: lang);
  }

  Mnemonic._(this._wordCount, this.lang) {
    _entropy = _generateEntropy(_wordCount);
  }

  Mnemonic._fromEntropy(List<int> entropy, this.lang) {
    _wordCount = WordCount.fromEntropy(entropy);
    _entropy = entropy;
  }

  List<int> getEntropy() {
    return _entropy;
  }

  List<String> getWords({WordLang? lang}) {
    if (this.lang == lang || lang == null) {
      return _words;
    }

    this.lang = lang;
    _calculateWords();
    return _words;
  }

  String getPhrases({WordLang? lang}) {
    var phraseBuffer = StringBuffer();

    for (var word in getWords(lang: lang)) {
      phraseBuffer.write(word);
      phraseBuffer.write(' ');
    }

    return phraseBuffer.toString().trimRight();
  }

  Future<List<int>> getSeed({String? passphrase}) async {
    final pbkdf2 = Pbkdf2(
      macAlgorithm: Hmac.sha512(),
      iterations: 2048,
      bits: 64 * BIT_PER_BYTE,
    );

    final password = SecretKey(getPhrases().codeUnits);

    final saltStr = passphrase == null ? 'mnemonic' : 'mnemonic$passphrase';
    final salt = saltStr.codeUnits;

    final seed = await pbkdf2.deriveKey(
      secretKey: password,
      nonce: salt,
    );

    return seed.extractBytes();
  }

  void _calculateWords() {
    _words = [];
    for (var i = 0; i < _entropyBitArray.length; i += 11) {
      var wordIndex = bitArrayToInt(_entropyBitArray.substring(i, i + 11));

      _words.add(getWordList(lang)![wordIndex]);
    }
  }

  String _getChecksumBitArray(WordCount wordCount, List<int> entropySha256) {
    var checksumByteLength = ((wordCount.entropyLength ~/ 32) ~/ BIT_PER_BYTE) + 1;

    return byteArrayToBitArray(entropySha256.sublist(0, checksumByteLength))
        .substring(0, wordCount.entropyLength ~/ 32);
  }

  List<int> _generateEntropy(WordCount wordCount) {
    var randomGenerator = Random.secure();
    return List<int>.generate(wordCount.entropyLength ~/ BIT_PER_BYTE, (i) => randomGenerator.nextInt(256));
  }
}
