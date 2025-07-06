import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_nasa_challenge/core/usecases/get_filtered_image_usecase.dart';
import 'package:flutter_nasa_challenge/core/usecases/get_image_usecase.dart';
import 'package:flutter_nasa_challenge/models/image/image_entity.dart';

part 'gallery_state.dart';

class GalleryCubit extends Cubit<GalleryState> {
  final filteredImageUseCase = Modular.get<GetFilteredImageUseCase>();
  final imageUseCase = Modular.get<GetImageUseCase>();
  final controller = TextEditingController();
  GalleryCubit() : super(InitialState());

  Future<void> getImageList() async {
    controller.text = "";
    emit(LoadingState());
    final response = await imageUseCase();
    emit(response.fold((l)=>FailureState(msg: l), (r)=>SuccessState(imageList: r)));
  }

  Future<void> getFilteredImageList({String? search}) async {
    emit(LoadingState());
    final response = await filteredImageUseCase(search ?? '');
    emit(response.fold((l)=>FailureState(msg: l), (r)=>SuccessState(imageList: r)));
  }
}