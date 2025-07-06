part of 'gallery_cubit.dart';

abstract class GalleryState extends Equatable {
  const GalleryState();

  @override
  List<Object> get props => [];
}

class InitialState extends GalleryState {}

class LoadingState extends GalleryState {}

class SuccessState extends GalleryState {
  final List<ImageEntity> imageList;

  const SuccessState({required this.imageList});
}

class FailureState extends GalleryState {
  final String msg;

  const FailureState({required this.msg});
}
