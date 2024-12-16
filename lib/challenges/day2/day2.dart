import 'package:advent_of_code_2024/utils/input_parse.dart';

class Day2 {
  void redNosedReports() async {
    List<String> fileReports =
        await readFile('./lib/challenges/day2/input.txt');
    List<List<int>> reports = [];
    List<int> aux = [];

    // Convert String Report List in Int Report List
    for (String report in fileReports) {
      List<String> reportLevels = report.split(" ");
      for (String level in reportLevels) {
        aux.add(int.parse(level));
      }
      reports.add(aux);
      aux = [];
    }

    // Part 1
    List<List<int>> unsafeReports = _totalSafeReports(reports);

    print("Total Unsafe Reports: ${unsafeReports.length}");

    // Part 2
    _totalSafeReportsWithProblemDampener(unsafeReports);
  }

  bool _isSafeForAscendentReports(List<int> report) {
    bool isSafeReport = false;

    for (int i = 0; i < report.length; i++) {
      if (i == report.length - 1) break;

      if (report[i] < report[i + 1] &&
          ((report[i] - report[i + 1]).abs() <= 3)) {
        isSafeReport = true;
      } else {
        isSafeReport = false;
        break;
      }
    }
    return isSafeReport;
  }

  bool _isSafeForDescedentReports(List<int> report) {
    bool isSafeReport = false;

    for (int i = 0; i < report.length; i++) {
      if (i == report.length - 1) break;

      if (report[i] > report[i + 1] &&
          ((report[i] - report[i + 1]).abs() <= 3)) {
        isSafeReport = true;
      } else {
        isSafeReport = false;
        break;
      }
    }
    return isSafeReport;
  }

  List<List<int>> _totalSafeReports(List<List<int>> reports) {
    bool isSafeReport = false;
    int totalSafeReports = 0;
    List<List<int>> unsafeReports = [];
    //int countLine = 1;

    for (List<int> report in reports) {
      //print("$countLine - $report");

      isSafeReport = _isSafeForDescedentReports(report);
      if (isSafeReport) {
        totalSafeReports++;
      } else {
        isSafeReport = _isSafeForAscendentReports(report);

        if (isSafeReport) {
          totalSafeReports++;
        } else {
          unsafeReports.add(report);
        }
      }
      //print(isSafeReport);
      //countLine++;
    }

    print("Total Safe Reports: $totalSafeReports");
    return unsafeReports;
  }

  void _totalSafeReportsWithProblemDampener(List<List<int>> unsafeReports) {
    int ascendent = 0;
    int decendent = 0;
    List<int> auxReport = [];
    int totalSafeReports = 0;

    for (List<int> report in unsafeReports) {
      ascendent = 0;
      decendent = 0;
      auxReport = List.of(report);

      for (int i = 0; i < report.length; i++) {
        if (i == report.length - 1) break;

        if (report[i] - report[i + 1] > 0) {
          decendent++;
        } else if (report[i] - report[i + 1] < 0) {
          ascendent++;
        }
      }

      if (ascendent > decendent) {
        for (int i = 0; i < report.length; i++) {
          if (i == report.length - 1) break;
          if (report[i] >= report[i + 1] ||
              ((report[i] - report[i + 1]).abs() > 3)) {
            auxReport.removeAt(i);
            if (_isSafeForAscendentReports(auxReport)) {
              totalSafeReports++;
              break;
            } else {
              auxReport = List.of(report);
              auxReport.removeAt(i + 1);

              if (_isSafeForAscendentReports(auxReport)) {
                totalSafeReports++;
              }
              break;
            }
          }
        }
      }

      if (decendent > ascendent) {
        for (int i = 0; i < report.length; i++) {
          if (i == report.length - 1) break;
          //print(i);
          if (report[i] <= report[i + 1] ||
              ((report[i] - report[i + 1]).abs() > 3)) {
            auxReport.removeAt(i);

            if (_isSafeForDescedentReports(auxReport)) {
              totalSafeReports++;
              break;
            } else {
              auxReport = List.of(report);
              auxReport.removeAt(i + 1);

              if (_isSafeForDescedentReports(auxReport)) {
                totalSafeReports++;
              }
              break;
            }
          }
        }
      }
    }
    print("Total Safe Reports after apply Problem Dampener: $totalSafeReports");
  }
}
