import 'package:random_string/random_string.dart' as random;

class Logic {
// Vigenere Cipher encryption and decryption
  String vigenere(String text, String key, int encrypt) {
    String result = '';
    int j = 0;
    for (var i = 0; i < text.length; i++) {
      if (encrypt == 1) {
        int x = (text.codeUnitAt(i) + key.codeUnitAt(j)) % 26 + 65;
        result += String.fromCharCode(x);
      } else {
        int y = ((text.codeUnitAt(i) - key.codeUnitAt(j)) % 26 + 26) % 26;
        result += String.fromCharCode(y + 65);
      }
      if (j < key.length - 1) {
        j++;
      } else {
        j = 0;
      }
    }
    return result;
  }

// Rail fence keyword encryption and decryption
  String railfenceEncrypt(var text, int key) {
    var row = key, col = text.length, x = 0, y = 0;
    var result = '';
    bool dir = false;
    var matrix = List.generate(row, (i) => List.filled(col, ""));
    for (var i = 0; i < text.length; i++) {
      if (x == 0 || x == row - 1) dir = !dir;
      matrix[x][y++] = text[i];
      dir ? x++ : x--;
    }
    for (var i = 0; i < row; i++) {
      for (var j = 0; j < col; j++) {
        if (matrix[i][j] != null) result += matrix[i][j];
      }
    }
    return result;
  }

  String railfenceDecrypt(var text, int key) {
    String result = '';
    int row = 0, col = 0, index = 0;
    bool dir = false;
    var matrix = List.generate(key, (i) => List.filled(text.length, ""));

    for (var i = 0; i < text.length; i++) {
      if (row == 0) dir = true;
      if (row == key - 1) dir = false;
      matrix[row][col++] = '*';
      dir ? row++ : row--;
    }

    for (var i = 0; i < key; i++) {
      for (var j = 0; j < text.length; j++) {
        if (matrix[i][j] == '*' && index < text.length) {
          matrix[i][j] = text[index++];
        }
      }
    }

    row = 0;
    col = 0;

    for (var i = 0; i < text.length; i++) {
      if (row == 0) dir = true;
      if (row == key - 1) dir = false;
      if (matrix[row][col] != '*') result += matrix[row][col++];
      dir ? row++ : row--;
    }

    return result;
  }

// Playfair cipher encryption & decryption

  String playfairEncrypt(var text, String key) {
    var table = '', result = '';
    text = text.replaceAll(' ', '');
    text = text.replaceAll('j', 'i');
    key = key.replaceAll(' ', '');
    text = text.toLowerCase();
    key = key.toLowerCase();

    for (var i = 0; i < text.length - 1; i++) {
      if (text[i] == text[i + 1]) {
        text =
            text.substring(0, i + 1) + 'x' + text.substring(i + 1, text.length);
      }
    }
    if (text.length % 2 != 0) text += 'x';

    var matrix = List.generate(5, (i) => List.filled(5, "")), index = 0;

    for (var i = 0; i < key.length; i++) {
      if (table.contains(key[i]) == false) {
        if (key[i] != 'j') table += key[i];
      }
    }

    for (var i = 'a'.codeUnitAt(0); i <= 'z'.codeUnitAt(0); i++) {
      if (table.contains(String.fromCharCode(i)) == false &&
          String.fromCharCode(i) != 'j') table += String.fromCharCode(i);
    }

    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        matrix[i][j] = table[index++];
      }
    }
    for (var i = 0; i < text.length; i += 2) {
      late int row1, row2, col1, col2;
      for (var j = 0; j < 5; j++) {
        if (matrix[j].contains(text[i]) == true) {
          row1 = j;
          col1 = matrix[j].indexOf(text[i]);
        }
        if (matrix[j].contains(text[i + 1]) == true) {
          row2 = j;
          col2 = matrix[j].indexOf(text[i + 1]);
        }
      }
      if (row1 == row2) {
        result += matrix[row1][(col1 + 1) % 5].toString();
        result += matrix[row2][(col2 + 1) % 5].toString();
      } else if (col1 == col2) {
        result += matrix[(row1 + 1) % 5][col1].toString();
        result += matrix[(row2 + 1) % 5][col2].toString();
      } else {
        result += matrix[row1][col2].toString();
        result += matrix[row2][col1].toString();
      }
    }
    return result;
  }

  String playfairDecrypt(var text, String key) {
    var table = '', result = '';
    text = text.replaceAll(' ', '');
    key = key.replaceAll(' ', '');
    text = text.toLowerCase();
    key = key.toLowerCase();

    var matrix = List.generate(5, (i) => List.filled(5, "")), index = 0;

    for (var i = 0; i < key.length; i++) {
      if (table.contains(key[i]) == false) {
        if (key[i] != 'j') table += key[i];
      }
    }

    for (var i = 'a'.codeUnitAt(0); i <= 'z'.codeUnitAt(0); i++) {
      if (table.contains(String.fromCharCode(i)) == false &&
          String.fromCharCode(i) != 'j') {
        table += String.fromCharCode(i);
      }
    }

    for (var i = 0; i < 5; i++) {
      for (var j = 0; j < 5; j++) {
        matrix[i][j] = table[index++];
      }
    }

    for (var i = 0; i < text.length; i += 2) {
      late int row1, row2, col1, col2;
      for (var j = 0; j < 5; j++) {
        if (matrix[j].contains(text[i]) == true) {
          row1 = j;
          col1 = matrix[j].indexOf(text[i]);
        }
        if (matrix[j].contains(text[i + 1]) == true) {
          row2 = j;
          col2 = matrix[j].indexOf(text[i + 1]);
        }
      }
      if (row1 == row2) {
        result += matrix[row1][(col1 - 1) % 5].toString();
        result += matrix[row2][(col2 - 1) % 5].toString();
      } else if (col1 == col2) {
        result += matrix[(row1 - 1) % 5][col1].toString();
        result += matrix[(row2 - 1) % 5][col2].toString();
      } else {
        result += matrix[row1][col2].toString();
        result += matrix[row2][col1].toString();
      }
    }
    return result;
  }

// Keyword cipher encryption and decryption

  String keywordEncrypt(String text, String key) {
    String fullKey = '', result = '';
    key = key.toUpperCase();
    text = text.toUpperCase();

    for (var i = 0; i < key.length; i++) {
      if (fullKey.contains(key[i]) == false && key[i] != ' ') fullKey += key[i];
    }

    for (var i = 'A'.codeUnitAt(0); i <= 'Z'.codeUnitAt(0); i++) {
      if (fullKey.contains(String.fromCharCode(i)) == false) {
        fullKey += String.fromCharCode(i);
      }
    }

    for (var i = 0; i < text.length; i++) {
      if (text[i] == ' ') {
        result += ' ';
      } else {
        result += fullKey[text[i].codeUnitAt(0) - 65];
      }
    }

    return result;
  }

  String keywordDecrypt(String text, String key) {
    String fullKey = '', result = '';
    key = key.toUpperCase();
    text = text.toUpperCase();

    for (var i = 0; i < key.length; i++) {
      if (fullKey.contains(key[i]) == false &&
          key[i] != ' ' &&
          key[i].codeUnitAt(0) >= 'A'.codeUnitAt(0) &&
          key[i].codeUnitAt(0) <= 'Z'.codeUnitAt(0)) fullKey += key[i];
    }

    for (var i = 'A'.codeUnitAt(0); i <= 'Z'.codeUnitAt(0); i++) {
      if (fullKey.contains(String.fromCharCode(i)) == false) {
        fullKey += String.fromCharCode(i);
      }
    }

    for (var i = 0; i < text.length; i++) {
      if (text[i] == ' ') {
        result += ' ';
      } else {
        result +=
            String.fromCharCode(fullKey.indexOf(text[i]) + 'A'.codeUnitAt(0));
      }
    }

    return result;
  }

  String columnarEncrypt(String plainText, String keyColumnar) {
    List<int> arrange = arrangeKey(keyColumnar);

    int lenkey = arrange.length;
    int lentext = plainText.length;

    double temp = lentext / lenkey;
    int row = temp.ceil();

    var grid = List.generate(row, (_) => List.filled(lenkey, ""));

    int z = 0;
    for (int x = 0; x < row; x++) {
      for (int y = 0; y < lenkey; y++) {
        if (lentext == z) {
          // at random alpha for trailing null grid
          grid[x][y] = RandomAlpha();
          z--;
        } else {
          grid[x][y] = plainText[z];
        }

        z++;
      }
    }
    String enc = "";
    for (int x = 0; x < lenkey; x++) {
      for (int y = 0; y < lenkey; y++) {
        if (x == arrange[y]) {
          for (int a = 0; a < row; a++) {
            enc = enc + grid[a][y];
          }
        }
      }
    }
    return enc;
  }

  String columnarDecrypt(String cipherText, String keyColumnar) {
    List<int> arrange = arrangeKey(keyColumnar);
    int lenkey = arrange.length;
    int lentext = cipherText.length;

    // int row = (int) Math.ceil((double) lentext / lenkey);
    double temp = lentext / lenkey;
    int row = temp.ceil();

    String regex = "(?<=\\G.{" + row.toString() + "})";
    List<String> get = cipherText.split(regex);

    // char[][] grid = new char[row][lenkey];
    var grid = List.generate(row, (_) => List.filled(lenkey, ""));

    for (int x = 0; x < lenkey; x++) {
      for (int y = 0; y < lenkey; y++) {
        if (arrange[x] == y) {
          for (int z = 0; z < row; z++) {
            grid[z][y] = get[arrange[y]][z];
          }
        }
      }
    }

    String dec = "";
    for (int x = 0; x < row; x++) {
      for (int y = 0; y < lenkey; y++) {
        dec = dec + grid[x][y];
      }
    }

    return dec;
  }

  List<int> arrangeKey(String keyColumnar) {
    //arrange position of grid
    List<String> keys = keyColumnar.split("");
    keys.sort();
    var num = List.filled(keys.length, 0);
    for (int x = 0; x < keys.length; x++) {
      for (int y = 0; y < keyColumnar.length; y++) {
        if (keys[x] == (keyColumnar[y] + "")) {
          num[y] = x;
          break;
        }
      }
    }

    return num;
  }

  String RandomAlpha() {
    //generate random alpha for null space
    String r = random.randomAlpha(1);
    return r;
  }

  String encryptVigenere(String input, String key) {
    input = input.replaceAll(' ', '');
    key = key.replaceAll(' ', '');
    input = input.toUpperCase();
    key = key.toUpperCase();
    String output = "";
    int j = 0;
    for (int i = 0; i < input.length; i++) {
      if (input[i].isNotEmpty) {
        output += String.fromCharCode(
            (input.codeUnitAt(i) + key.codeUnitAt(j)) % 26 + 65);
      } else {
        output += input[i];
      }
      if (j < key.length - 1) {
        j++;
      } else {
        j = 0;
      }
    }
    return output;
  }

  int mod(int val, int mod) {
    return (val % mod + mod) % mod;
  }

  String decryptVigenere(String input, String key) {
    input = input.replaceAll(' ', '');
    key = key.replaceAll(' ', '');
    input = input.toUpperCase();
    key = key.toUpperCase();
    String output = "";
    int j = 0;

    for (int i = 0; i < input.length; i++) {
      if (input[i].isNotEmpty) {
        output += String.fromCharCode(
            mod((input.codeUnitAt(i) - key.codeUnitAt(j)), 26) + 65);
      } else {
        output += input[i];
      }

      if (j < key.length - 1)
        j++;
      else
        j = 0;
    }
    return output;
  }

  String caesar(String text, int key, int encrypt) {
    String result = "";

    for (var i = 0; i < text.length; i++) {
      int ch = text.codeUnitAt(i), x;
      int? offset;

      if (ch >= 'a'.codeUnitAt(0) && ch <= 'z'.codeUnitAt(0)) {
        offset = 97;
      } else if (ch >= 'A'.codeUnitAt(0) && ch <= 'Z'.codeUnitAt(0)) {
        offset = 65;
      } else if (ch == ' '.codeUnitAt(0)) {
        result += " ";
        continue;
      }

      if (encrypt == 1) {
        x = (ch + key - offset!) % 26;
      } else {
        x = (ch - key - offset!) % 26;
      }

      result += String.fromCharCode(x + offset);
    }
    return result;
  }

  String autokeyEncrypt(String plainText, String key) {
    String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    plainText = plainText.toUpperCase();
    int len = plainText.length;

    String subkey = key + plainText;
    subkey = subkey.substring(0, subkey.length - key.length);

    String sb = "";
    for (int x = 0; x < len; x++) {
      int get1 = alpha.indexOf(plainText[x]);
      int get2 = alpha.indexOf(subkey[x]);

      int total = (get1 + get2) % 26;

      sb += alpha[total];
    }

    return sb;
  }

  String autokeyDecrypt(String cipherText, String key) {
    String alpha = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    cipherText = cipherText.toUpperCase();
    int len = cipherText.length;

    String current = key;
    String sb = "";

    for (int x = 0; x < len; x++) {
      int get1 = alpha.indexOf(cipherText[x]);
      int get2 = alpha.indexOf(current[x]);

      int total = (get1 - get2) % 26;
      total = (total < 0) ? total + 26 : total;
      sb += alpha[total];

      current += alpha[total];
    }

    return sb;
  }

  String affineEncrypt(String msg, int a, int b) {
    String cipher = "";
    var alphabet = [
      ["a", 1],
      ["b", 2]
    ];
    for (int i = 0; i < msg.length; i++) {
      cipher += msg[i] + " ";
    }

    return cipher;
  }
// End of function
}

class AtbashLogic {
  int _azU = 155;
  int _azL = 219;

  String _convert(String text) {
    StringBuffer cipher = StringBuffer();

    for (var i = 0; i < text.length; i++) {
      String ch = text[i];

      if (isLetter(ch)) {
        cipher.write(String.fromCharCode(
            (isUpper(ch) ? _azU : _azL) - ch.codeUnitAt(0)));
      } else {
        cipher.write(ch);
      }
    }

    return cipher.toString();
  }

  /// Encrypt [text].
  String encrypt(String text) => _convert(text);

  /// Decrypt [text].
  String decrypt(String text) => _convert(text);
}

final String alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
final String digits = "0123456789";
final String punctuation = "!\"#\$%&'()*+,-./:;<=>?@[\\]^_`{|}~";

// check if string is digit
bool isDigit(String s) => RegExp(r"^[0-9]+$").hasMatch(s);

// check if string is letter
bool isLetter(String s) => RegExp(r"^[a-zA-Z]+$").hasMatch(s);

// check if string is lowercase
bool isLower(String s) {
  var c = s.codeUnitAt(0);

  return c >= 0x61 && c <= 0x7A;
}

// check if string is uppercase
bool isUpper(String s) {
  var c = s.codeUnitAt(0);

  return c >= 0x41 && c <= 0x5A;
}

// check if string is punctuation
bool isPunctuation(String s) =>
    RegExp(r"""[!"#$%&'()*+,-./:;<=>?@[\\\]^_`{|}~]""").hasMatch(s);

// reverse map
Map reverseMap(Map m) => m.map((k, v) => MapEntry(v, k));

// simple python range in dart
List<int> range(int end, {start: 0}) => [for (var i = start; i < end; i++) i];
