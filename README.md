# How to test

## Without workspace

```bash
dart pub -C app/a get
(cd app/a; dart run build_runner build)
dart analyze
```

Everything is fine, no errors nor warnings.

Filesystem:

```bash
tree -I .git -a    
.
├── .gitignore
├── app
│   └── a
│       ├── .dart_tool
│       │   ├── build
│       │   │   ├── entrypoint
│       │   │   │   ├── .packageLocations
│       │   │   │   ├── build.dart
│       │   │   │   └── build.dart.dill
│       │   │   ├── fcd1995bc647fb959e82ea360c6c2c9a
│       │   │   │   └── asset_graph.json
│       │   │   └── generated
│       │   │       └── a
│       │   │           └── lib
│       │   │               └── src
│       │   │                   └── my_task.task.dart
│       │   ├── package_config.json
│       │   ├── package_graph.json
│       │   └── pub
│       │       └── bin
│       │           └── build_runner
│       │               └── build_runner.dart-3.8.0.snapshot
│       ├── README
│       ├── build.yaml
│       ├── lib
│       │   ├── builders.dart
│       │   └── src
│       │       ├── annotations.dart
│       │       └── my_task.dart
│       ├── main.dart
│       ├── pubspec.lock
│       └── pubspec.yaml
└── pubspec.yaml
```

Reset

```
git clean -fdx
```

## With workspace

*Uncomment pubspec section in root and `app/a` folder*

```bash
sed -i 's/# //' pubspec.yaml app/a/pubspec.yaml 
```

```bash
dart pub -C app/a get
(cd app/a; dart run build_runner build)
dart analyze
```

Analyzer found errors "Target of URI doesn't exist"

Filesystem:

```bash
tree -I .git -a
.
├── .dart_tool
│   ├── package_config.json
│   ├── package_graph.json
│   └── pub
│       ├── bin
│       │   └── build_runner
│       │       └── build_runner.dart-3.8.0.snapshot
│       └── workspace_ref.json
├── .gitignore
├── README.md
├── app
│   └── a
│       ├── .dart_tool
│       │   ├── build
│       │   │   ├── entrypoint
│       │   │   │   ├── .packageLocations
│       │   │   │   ├── build.dart
│       │   │   │   └── build.dart.dill
│       │   │   ├── fcd1995bc647fb959e82ea360c6c2c9a
│       │   │   │   └── asset_graph.json
│       │   │   └── generated
│       │   │       └── a
│       │   │           └── lib
│       │   │               └── src
│       │   │                   └── my_task.task.dart
│       │   └── pub
│       │       └── workspace_ref.json
│       ├── README
│       ├── build.yaml
│       ├── lib
│       │   ├── builders.dart
│       │   └── src
│       │       ├── annotations.dart
│       │       └── my_task.dart
│       ├── main.dart
│       └── pubspec.yaml
├── pubspec.lock
└── pubspec.yaml
```

To fix analyzer i can copy build folder

```bash
cp -r app/a/.dart_tool/build .dart_tool 
dart analyze
```

Everything is fine now

reset

```bash
git clean -fdx
git checkout .
```
