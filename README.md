# bip0039_flutter

#### [BIP0039](https://github.com/bitcoin/bips/blob/master/bip-0039.mediawiki) implementation for flutter and dart.

#### Check `/lib/bip0039` directory fot implementation and `/test/vectors_test.dart` for [vector tests](https://github.com/trezor/python-mnemonic/blob/master/vectors.json).

### Usage:

#### 1) Generate random phrases:

```
var mnemonic = await Mnemonic.generate(wordCount);
```

#### 2) Retrieve from phrases:

```
var mnemonic = await Mnemonic.fromPhrase(phrases);
```

#### 3) Retrieve from entropy:

```
var mnemonic = await Mnemonic.fromEntropy(fromHex(hex_str_entropy));
var mnemonic = await Mnemonic.fromEntropy(int_list_entropy));
```

### Methods:

```
mnemonic.getWords(); //get phrases as array
mnemonic.getPhrases(); //get phrases as string
mnemonic.getSeed(optional_passphrase); //get seed
mnemonic.getEntropy() //get entropy 

```

### Other useful classes and functions:

#### 1) `WordCount` class:

```
WordCount.word12(); //generate 12 word phrase
WordCount.word15(); //generate 15 word phrase
WordCount.word18(); //generate 18 word phrase
WordCount.word21(); //generate 21 word phrase
WordCount.word24(); //generate 24 word phrase
WordCount.fromEntropy(int_list_entropy); //get phrase words count from given entropy
```

#### 2) `WordLang` enum and `getWordList` function:

```
WordLang.EN //use EN word list fot generating phrases.
getWordList(wordLang) //get word list of given langunage.
```

#### 3) `Utils.dart` file:

```
var int_list = fromHex(str_hex); //convert hex string to byte array.
var str_hex = toHex(int_list); //convert byte array to hex string.
var bit_string = intToBitArray(number); //get bits of given number as string.
var number = bitArrayToInt(bit_string); //convert bit array string to number.
var bit_array = byteArrayToBitArray(int_list); //get bits of given byte array as string.
```
