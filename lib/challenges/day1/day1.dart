import "package:advent_of_code_2024/utils/input_parse.dart";

class Day1 {
  void historianHysteria() async {

    // Part 1
    List<String> lists = await readFile('./lib/challenges/day1/input.txt');
    List<int> leftList = [];
    List<int> rightList = [];
    int totalDistance = 0;

    for (String line in lists) {
      leftList.add(int.parse(line.split("   ")[0]));
      rightList.add(int.parse(line.split("   ")[1]));
    }

    leftList.sort();
    rightList.sort();

    for (int i = 0; i < lists.length; i++) {
      totalDistance += (leftList[i] - rightList[i]).abs();
    }

    print("Total Distance: $totalDistance");

    // Part 2
    _similarityScoreCalculation(leftList, rightList);
  }

  void _similarityScoreCalculation(List<int> leftList, List<int> rightList) {
    int similarityScore = 0;
    int frequencyNumber = 0;
    
    for (int i = 0; i < leftList.length; i++) {
      for (int j = 0; j < rightList.length; j++) {
        if (leftList[i] == rightList[j]) {
          frequencyNumber++;
        }
      }
      similarityScore += (leftList[i] * frequencyNumber);
      frequencyNumber = 0;
    }

    print("Similarity Score: $similarityScore");
  }
}
