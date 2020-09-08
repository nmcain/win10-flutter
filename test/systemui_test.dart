import 'dart:io';

import 'package:GeneratedApp/launcher.dart';
import 'package:GeneratedApp/launcher_toggle.dart';
import 'package:GeneratedApp/main.dart';
import 'package:GeneratedApp/quick_settings.dart';
import 'package:GeneratedApp/status_tray.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
  isTesting = true;
  Box box;
  var settingsInit = () async {
    //TestWidgetsFlutterBinding.ensureInitialized();
    Directory dir = await getApplicationDocumentsDirectory();
    Hive.init(dir.path);
    box = await Hive.openBox<String>("settings");
    await box.clear(); //start with fresh settings
  };
  await settingsInit();
  testWidgets('System UI test', (WidgetTester tester) async {
    print("Opening Pangolin"); // ---
    await tester.pumpWidget(Pangolin());
    await tester.pump();
    expect(find.byType(ErrorWidget, skipOffstage: false), findsNothing); //no error widgets here

    print("Testing Quick Settings"); // ---
    expect(find.byType(QuickSettings), findsNothing);
    await tester.tap(find.byType(StatusTrayWidget));
    print((await tester.pumpAndSettle()).toString() + " frames on animation!");
    await tester.idle();
    expect(find.byType(QuickSettings), findsOneWidget);
    expect(find.byType(ErrorWidget, skipOffstage: false), findsNothing); //no error widgets here

    print("Testing Launcher"); // ---
    expect(find.byType(ErrorWidget, skipOffstage: false), findsNothing); //no error widgets here
    expect(find.byType(LauncherWidget), findsNothing);
    await tester.tap(find.byType(LauncherToggleWidget));
    print((await tester.pumpAndSettle()).toString() + " frames on animation!");
    await tester.idle();
    expect(find.byType(LauncherWidget), findsOneWidget);
    expect(find.byType(ErrorWidget, skipOffstage: false), findsNothing); //no error widgets here
  }, skip: true);
  //print("Maybe this test works better on a different version of Flutter");
}
