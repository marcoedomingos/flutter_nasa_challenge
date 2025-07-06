import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_nasa_challenge/core/datasources/local_image_datasource.dart';
import 'package:flutter_nasa_challenge/models/image/image_entity.dart';
import 'package:flutter_nasa_challenge/models/image/image_model.dart';
import 'package:flutter_nasa_challenge/module/app_module.dart';
import 'package:flutter_nasa_challenge/views/details/details_screen.dart';
import 'package:flutter_nasa_challenge/views/gallery/gallery_screen.dart';
import 'package:flutter_nasa_challenge/views/gallery/widgets/search_field_widget.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';

void main() {
  late ImageEntity image;
  final imageJson = {
    "copyright": "Zarcos Palma",
    "date": "2023-01-07",
    "explanation":
        "On January 3, two space stations already illuminated by sunlight in low Earth orbit crossed this dark predawn sky. Moving west to east (left to right) across the composited timelapse image China's Tiangong Space Station traced the upper trail captured more than an hour before the local sunrise. Seen against a starry background Tiangong passes just below the inverted Big Dipper asterism of Ursa Major near the peak of its bright arc, and above north pole star Polaris. But less than five minutes before, the International Space Station had traced its own sunlit streak across the dark sky. Its trail begins just above the W-shape outlined by the bright stars of Cassiopeia near the northern horizon. The dramatic foreground spans an abandoned mine at Achada do Gamo in southeastern Portugal.",
    "hdurl":
        "https://apod.nasa.gov/apod/image/2301/ISS_TIANHE_FINAL_4_APOD.jpg",
    "media_type": "image",
    "service_version": "v1",
    "title": "Space Stations in Low Earth Orbit",
    "url":
        "https://apod.nasa.gov/apod/image/2301/ISS_TIANHE_FINAL_4_APOD1024.jpg"
  };

  setUpAll(() async {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      MethodChannel('plugins.flutter.io/path_provider'),
      (MethodCall methodCall) async => '.',
    );
    await Hive.initFlutter();
    Hive.registerAdapter(ImageEntityAdapter());
    Modular.init(AppModule());
    Modular.setInitialRoute("/");
    image = ImageModel.fromJson(imageJson);
  });

  group("Testing the gallery and details screen", () {
    testWidgets(
        "Confirm that the Gallery Screen is opened and return the list of images",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: GalleryScreen(),
      ));

      final findTitle = find.text("NASA");
      final findSubtitle = find.text("Astronomy Picture of the Day");
      final findSearchField = find.byType(SearchFieldWidget);

      expect(findSearchField, findsOneWidget);
      expect(findSubtitle, findsOneWidget);
      expect(findTitle, findsOneWidget);
    });

    testWidgets(
        "Should open the details screen",
        (tester) async {
      await tester.pumpWidget(MaterialApp(
        home: DetailsScreen(image: image),
      ));

      await tester.pumpAndSettle();

      await tester.pump(const Duration(seconds: 3));

      final findTitle = find.text("Título");
      final findDateLabel = find.text("Data");
      final findDateText = find.text("2023-01-07");
      final findDetails = find.text("Detalhes");

      expect(findTitle, findsOneWidget);
      expect(findDateLabel, findsOneWidget);
      expect(findDateText, findsOneWidget);
      expect(findDetails, findsOneWidget);

      final findIconButton = find.byType(IconButton);

      await tester.ensureVisible(findIconButton.first);

      await tester.tap(findIconButton.first);

      await tester.pump(const Duration(seconds: 1));

      expect(Modular.to.path, "/");
    });
  });
}
