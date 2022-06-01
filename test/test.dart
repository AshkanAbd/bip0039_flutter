import 'package:bip39/bip0039/utils.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Bit converters with leading zero', () {
    final numbers = {
      0: '00000000',
      10: '00001010',
      26: '00011010',
      85: '01010101',
      110: '01101110',
      169: '10101001',
      200: '11001000',
      214: '11010110',
    };

    for (var number in numbers.keys) {
      var bitArray = intToBitArray(number);
      expect(bitArray, numbers[number]);

      var num = bitArrayToInt(bitArray);
      expect(num, number);
    }
  });

  test('Bit converters without leading zero', () {
    final numbers = {
      0: '0',
      10: '1010',
      26: '11010',
      85: '1010101',
      110: '1101110',
      169: '10101001',
      200: '11001000',
      214: '11010110',
    };

    for (var number in numbers.keys) {
      var bitArray = intToBitArray(number, leadingZero: false);
      expect(bitArray, numbers[number]);

      var num = bitArrayToInt(bitArray);
      expect(num, number);
    }
  });

  test('fromHex and toHex', () {
    var byteArray = fromHex('7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f7f');

    for (var i in byteArray) {
      expect(i, 127);
    }

    var data = [
      46,
      137,
      5,
      129,
      155,
      135,
      35,
      254,
      44,
      29,
      22,
      24,
      96,
      229,
      238,
      24,
      48,
      49,
      141,
      191,
      73,
      168,
      59,
      212,
      81,
      207,
      184,
      68,
      12,
      40,
      189,
      111,
      164,
      87,
      254,
      18,
      150,
      16,
      101,
      89,
      163,
      200,
      9,
      55,
      161,
      193,
      6,
      155,
      227,
      163,
      165,
      189,
      56,
      30,
      230,
      38,
      14,
      141,
      151,
      57,
      252,
      225,
      246,
      7
    ];
    var hex = toHex(data);

    expect(hex,
        '2e8905819b8723fe2c1d161860e5ee1830318dbf49a83bd451cfb8440c28bd6fa457fe1296106559a3c80937a1c1069be3a3a5bd381ee6260e8d9739fce1f607');
  });
}
