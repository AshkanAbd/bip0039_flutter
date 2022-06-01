import 'package:bip39/bip0039/utils.dart';

class WordCount {
  static WordCount word12() {
    return WordCount._(128);
  }

  static WordCount word15() {
    return WordCount._(160);
  }

  static WordCount word18() {
    return WordCount._(192);
  }

  static WordCount word21() {
    return WordCount._(224);
  }

  static WordCount word24() {
    return WordCount._(256);
  }

  static WordCount fromEntropy(List<int> entropy) {
    return WordCount._(entropy.length * BIT_PER_BYTE);
  }

  late final int _count;
  late final int _entropyLength;

  WordCount._(this._entropyLength) {
    _count = ((_entropyLength / 32) + _entropyLength) ~/ BIT_PER_WORD;
  }

  int get entropyLength => _entropyLength;

  int get count => _count;
}
