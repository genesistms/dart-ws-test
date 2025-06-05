import 'package:build/build.dart';

import 'dart:async';

Builder taskBuilder(BuilderOptions options) => TaskBuilder();

class TaskBuilder implements Builder {
  @override
  Map<String, List<String>> get buildExtensions => {
    r'.dart': ['.task.dart'],
  };

  @override
  FutureOr<void> build(BuildStep buildStep) async {
    log.fine("Running Task Builder");

    final lines = (await buildStep.readAsString(buildStep.inputId)).split('\n');

    for (final line in lines) {
      final str = line.trim();
      if (str.startsWith("@TaskClass")) {
        return buildStep.writeAsString(
          buildStep.inputId.changeExtension('.task.dart'),
          "final myvar = '" + buildStep.inputId.path + "';",
        );
      }
    }
  }
}
