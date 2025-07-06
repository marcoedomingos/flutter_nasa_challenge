import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_nasa_challenge/core/datasources/image_datasource.dart';
import 'package:flutter_nasa_challenge/core/datasources/local_image_datasource.dart';
import 'package:flutter_nasa_challenge/core/services/connection/connection_service.dart';
import 'package:flutter_nasa_challenge/core/services/connection/i_connection_service.dart';
import 'package:flutter_nasa_challenge/core/services/network/i_network_service.dart';
import 'package:flutter_nasa_challenge/core/services/network/network_service.dart';
import 'package:flutter_nasa_challenge/core/usecases/get_filtered_image_usecase.dart';
import 'package:flutter_nasa_challenge/core/usecases/get_image_usecase.dart';
import 'package:flutter_nasa_challenge/views/details/details_screen.dart';
import 'package:flutter_nasa_challenge/views/gallery/cubit/gallery_cubit.dart';
import 'package:flutter_nasa_challenge/views/gallery/gallery_screen.dart';

class AppModule extends Module {
  AppModule();

  @override
  void binds(i) {
    i.add<ImageDatasource>(
        () => ImageDatasource(networkService: i.get<INetworkService>()));
    i.add<LocalImageDatasource>(() => LocalImageDatasource());
    i.add<GetFilteredImageUseCase>(() => GetFilteredImageUseCase(
          localImageDatasource: i.get<LocalImageDatasource>(),
          connectionService: i.get<IConnectionService>(),
          datasource: i.get<ImageDatasource>(),
        ));
    i.add<GetImageUseCase>(() => GetImageUseCase(
          localImageDatasource: i.get<LocalImageDatasource>(),
          connectionService: i.get<IConnectionService>(),
          datasource: i.get<ImageDatasource>(),
        ));
    i.add<IConnectionService>(() => ConnectionService());
    i.add<INetworkService>(() => NetworkService());
    i.add<GalleryCubit>(() => GalleryCubit());
  }

  @override
  void routes(r) {
    r.child('/', child: (_) => const GalleryScreen());
    r.child('/details', child: (_) => DetailsScreen(image: r.args.data));
  }
}
