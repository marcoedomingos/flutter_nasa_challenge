import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_nasa_challenge/models/image/image_entity.dart';
import 'package:flutter_nasa_challenge/models/image/image_model.dart';
import 'package:flutter_nasa_challenge/module/app_module.dart';
import 'package:flutter_nasa_challenge/views/gallery/cubit/gallery_cubit.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hive_flutter/adapters.dart';

void main() {
  final imageList = [ImageModel.fromJson({
    "copyright": "Zarcos Palma",
    "date": "2023-01-07",
    "explanation": "On January 3, two space stations already illuminated by sunlight in low Earth orbit crossed this dark predawn sky. Moving west to east (left to right) across the composited timelapse image China's Tiangong Space Station traced the upper trail captured more than an hour before the local sunrise. Seen against a starry background Tiangong passes just below the inverted Big Dipper asterism of Ursa Major near the peak of its bright arc, and above north pole star Polaris. But less than five minutes before, the International Space Station had traced its own sunlit streak across the dark sky. Its trail begins just above the W-shape outlined by the bright stars of Cassiopeia near the northern horizon. The dramatic foreground spans an abandoned mine at Achada do Gamo in southeastern Portugal.",
    "hdurl": "https://apod.nasa.gov/apod/image/2301/ISS_TIANHE_FINAL_4_APOD.jpg",
    "media_type": "image",
    "service_version": "v1",
    "title": "Space Stations in Low Earth Orbit",
    "url": "https://apod.nasa.gov/apod/image/2301/ISS_TIANHE_FINAL_4_APOD1024.jpg"
  })];

  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      MethodChannel('plugins.flutter.io/path_provider'),
          (MethodCall methodCall) async => '.',
    );
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
      MethodChannel('dev.fluttercommunity.plus/connectivity'),
          (MethodCall methodCall) async => [],
    );
    await Hive.initFlutter();
    Hive.registerAdapter(ImageEntityAdapter());
    Modular.init(AppModule());
  });

  group("Testing gallery cubit methods", () {
    blocTest<GalleryCubit, GalleryState>(
      "Should return a list of the images",
      build: () => GalleryCubit(),
      act: (cubit) => cubit.getImageList(),
      expect: (){
        return <GalleryState>[
          LoadingState(),
          SuccessState(imageList: imageList)
        ];
      }
    );

    blocTest<GalleryCubit, GalleryState>(
        "Should return a list of the images that the date are equal to the searched date",
        build: () => GalleryCubit(),
        act: (cubit) => cubit.getFilteredImageList(search: "2023-01-07"),
        expect: (){
          return <GalleryState>[
            LoadingState(),
            SuccessState(imageList: imageList)
          ];
        }
    );

    blocTest<GalleryCubit, GalleryState>(
        "Should return a list of the images that the title are equal to the searched title",
        build: () => GalleryCubit(),
        act: (cubit) => cubit.getFilteredImageList(search: "Space"),
        expect: (){
          return <GalleryState>[
            LoadingState(),
            SuccessState(imageList: imageList)
          ];
        }
    );

    blocTest<GalleryCubit, GalleryState>(
        "Should return the failure state because there is no image saved with the given title",
        build: () => GalleryCubit(),
        act: (cubit) => cubit.getFilteredImageList(search: "Test"),
        expect: (){
          return <GalleryState>[
            LoadingState(),
            const FailureState(msg: "Pesquisa vazia")
          ];
        }
    );

    blocTest<GalleryCubit, GalleryState>(
        "Should return the failure state because there is no image saved with the given date",
        build: () => GalleryCubit(),
        act: (cubit) => cubit.getFilteredImageList(search: "2022-13-13"),
        expect: (){
          return <GalleryState>[
            LoadingState(),
            const FailureState(msg: "Pesquisa vazia")
          ];
        }
    );
  });
}
