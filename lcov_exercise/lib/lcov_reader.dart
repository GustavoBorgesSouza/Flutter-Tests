import 'dart:io';

import 'package:lcov/line_report.dart';

// to run main with args: dart .\lib\lcov_reader.dart .\coverage\lcov.info

void main(List<String> args) {
  final result = coverage(args[0]);
  print(result);
}

String coverage(String lcovPath) {
  final file = File(lcovPath);
  final content = file.readAsLinesSync();

  final reports = <LineReport>[];

  var sf = '';
  var lf = 0;
  var lh = 0;

  for (var text in content) {
    if (text == "end_of_record") {
      final report = LineReport(
        sourceFile: sf,
        lineFound: lf,
        lineHit: lh,
      );

      reports.add(report);
      continue;
    }

    final line = text.split(':');

    if (line[0] == 'SF') {
      sf = line[1];
    } else if (line[0] == "LF") {
      lf = int.parse(line[1]);
    } else if (line[0] == "LH") {
      lh = int.parse(line[1]);
    }
  }

  var totalLF = 0;
  var totalLH = 0;

  for (var report in reports) {
    totalLF += report.lineFound;
    totalLH += report.lineHit;
  }

  final percentage = (totalLH / totalLF) * 100;

  return "${percentage.round()}%";
}

/// SF = source file
/// DA =
/// LF = Lines found
/// LH = Lines hit
