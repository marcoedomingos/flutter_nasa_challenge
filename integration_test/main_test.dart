import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_nasa_challenge/models/image/image_entity.dart';
import 'package:flutter_nasa_challenge/module/app_module.dart';
import 'package:flutter_nasa_challenge/views/gallery/widgets/search_field_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:integration_test/integration_test.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await Hive.initFlutter();
    Hive.registerAdapter(ImageEntityAdapter());
    Modular.init(AppModule());
    Modular.setInitialRoute("/");
  });

  group("end-to-end test", () {
    testWidgets(
        "Confirm that the Gallery Screen is opened and return the list of images",
        (tester) async {
      await tester.pumpWidget(MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ));

      await tester.pumpAndSettle();

      final findTitle = find.text("NASA");
      final findSubtitle = find.text("Astronomy Picture of the Day");
      final findSearchField = find.byType(SearchFieldWidget);

      expect(findSearchField, findsOneWidget);
      expect(findSubtitle, findsOneWidget);
      expect(findTitle, findsOneWidget);

      final findImage = find.byType(CachedNetworkImage);

      await tester.ensureVisible(findImage.first);

      expect(Modular.to.path, "/");
      expect(findImage, findsWidgets);
    });

    testWidgets(
        "Should Open the gallery screen and then click in one of the images and open the details screen and then go back gallery screen",
        (tester) async {
      await tester.pumpWidget(MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routeInformationParser: Modular.routeInformationParser,
        routerDelegate: Modular.routerDelegate,
      ));

      await tester.pumpAndSettle();

      final findListView = find.byType(ListView);

      final findGestures = find.descendant(of: findListView, matching: find.byType(GestureDetector));

      final findTitle = find.descendant(of: findGestures, matching: find.byType(Text));

      await tester.pumpAndSettle();

      await tester.ensureVisible(findTitle.first);

      await tester.tap(findTitle.first);

      await tester.pumpAndSettle();

      expect(Modular.to.path, "/details");

      await tester.pump(const Duration(seconds: 3));

      final findIconButton = find.byType(IconButton);

      await tester.ensureVisible(findIconButton.first);

      await tester.tap(findIconButton.first);

      await tester.pump(const Duration(seconds: 1));

      expect(Modular.to.path, "/");
    });

    testWidgets("Should Open the gallery screen, tap at switch to date filter then tap at the search field, select date and the return the image according to the selected date",
            (tester) async {
          await tester.pumpWidget(MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routeInformationParser: Modular.routeInformationParser,
            routerDelegate: Modular.routerDelegate,
          ));

          await tester.pumpAndSettle();

          final findSearchField = find.byType(SearchFieldWidget);

          await tester.tap(findSearchField);

          await tester.pumpAndSettle();

          final findCalendarWidget = find.byType(CalendarDatePicker);

          final findDay = find.text("1");

          expect(findCalendarWidget, findsOneWidget);

          expect(findDay, findsOneWidget);

          await tester.tap(findDay.first);

          await tester.pumpAndSettle();

          final findListView = find.byType(ListView);

          final findDateText = find.text(DateTime(DateTime.now().year, DateTime.now().month).toString().substring(0, 10));

          expect(findListView, findsOneWidget);
          expect(findDateText, findsNWidgets(2));
        });
  });
}
