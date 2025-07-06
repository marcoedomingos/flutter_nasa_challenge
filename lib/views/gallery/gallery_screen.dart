import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_nasa_challenge/views/gallery/cubit/gallery_cubit.dart';
import 'package:flutter_nasa_challenge/views/gallery/widgets/search_field_widget.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({super.key});

  @override
  State<GalleryScreen> createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  GalleryCubit cubit = Modular.get<GalleryCubit>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          "NASA",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width/ 1.1,
          child: Column(
            children: [
              Divider(
                thickness: 1.0,
                height: 2.0,
                color: Colors.grey,
              ),
              const SizedBox(height: 18.0),
              SearchFieldWidget(
                controller: cubit.controller,
                hint: "Selecione uma data",
                icon: Icons.search,
                iconColor: Colors.black,
                onFinished: (value) {
                  cubit.getFilteredImageList(search: value);
                },
              ),
              Text(
                'Astronomy Picture of the Day',
                style: TextStyle(color: Colors.grey),
              ),
              const SizedBox(height: 18.0),
              Expanded(
                child: BlocProvider<GalleryCubit>(
                  create: (_) {
                    if (cubit.isClosed) {
                      cubit = Modular.get<GalleryCubit>();
                    }
                    cubit.getImageList();
                    return cubit;
                  },
                  child: BlocBuilder<GalleryCubit, GalleryState>(
                    builder: (context, state) {
                      if (state is SuccessState) {
                        return ListView.builder(
                          itemCount: state.imageList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                Modular.to.pushNamed("/details",
                                    arguments: state.imageList[index]);
                              },
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width: MediaQuery.sizeOf(context).width,
                                    height: MediaQuery.sizeOf(context).height / 2,
                                    child: CachedNetworkImage(
                                      imageUrl: state.imageList[index].url!,
                                      progressIndicatorBuilder: (_, c, w) => Center(child: CircularProgressIndicator()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Text(state.imageList[index].title!),
                                  Text("${state.imageList[index].date}"),
                                  const SizedBox(height: 18.0),
                                ],
                              ),
                            );
                          },
                        );
                      }

                      if (state is FailureState) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                state.msg,
                                textAlign: TextAlign.center,
                              ),
                              IconButton(
                                onPressed: () => cubit.getImageList(),
                                icon: Icon(
                                  Icons.refresh,
                                  size: 50,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        );
                      }

                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 18.0),
            ],
          ),
        ),
      ),
    );
  }
}
