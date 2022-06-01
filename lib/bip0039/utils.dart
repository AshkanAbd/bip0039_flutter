List<int> fromHex(String s) {
  var list = <int>[];

  for (var i = 0; i < s.length; i += 2) {
    list.add(int.parse(s.substring(i, i + 2), radix: 16));
  }

  return list;
}

String toHex(List<int> list) {
  var buffer = StringBuffer();

  for (var i in list) {
    buffer.write(i.toRadixString(16).padLeft(2, '0'));
  }

  return buffer.toString();
}

const BIT_PER_BYTE = 8;
const BIT_PER_WORD = 11;
final _binaryPattern = RegExp(r'(\d+)');

String intToBitArray(int number, {leadingZero = true, padding = 8}) {
  var bitArray = number.toRadixString(2);

  if (!leadingZero) {
    return bitArray;
  }

  return bitArray.padLeft(padding, '0');
}

int bitArrayToInt(String binaryString) {
  return int.parse(_binaryPattern.firstMatch(binaryString)!.group(1)!, radix: 2);
}

String byteArrayToBitArray(List<int> byteArray, {leadingZero = true, padding = 8}) {
  var bitArrayBuilder = StringBuffer();
  for (var b in byteArray) {
    bitArrayBuilder.write(intToBitArray(b, leadingZero: leadingZero, padding: padding));
  }

  return bitArrayBuilder.toString();
}
