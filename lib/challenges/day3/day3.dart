import 'package:advent_of_code_2024/utils/input_parse.dart';

class Day3 {
  void mullItOver() async {
    List<String> sourceCode = await readFile('./lib/challenges/day3/input.txt');
    int multiplyResult = 0;

    // Part 1
    for (String piece in sourceCode) {
      multiplyResult += _decodeAndExecuteMulFunctions(piece);
    }

    print(multiplyResult);

  }

  int _decodeAndExecuteMulFunctions(String piece) {
    int result = 0;
    RegExp regExp = RegExp(r'mul\(\d{1,3}\,\d{1,3}\)');

    Iterable<Match> matches = regExp.allMatches(piece);

    List<String> mulFunctions = [];
    for (final Match m in matches) {
      String match = m[0]!;
      mulFunctions.add(match);
    }

    for (String mulFunction in mulFunctions) {
      int startString = mulFunction.indexOf("(");
      int endString = mulFunction.indexOf(")");

      List<String> numbersString =
          mulFunction.substring(startString + 1, endString).split(",");

      result += int.parse(numbersString[0]) * int.parse(numbersString[1]);
    }
    return result;
  }

}
