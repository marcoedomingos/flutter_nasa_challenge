import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_nasa_challenge/models/image/image_entity.dart';

class DetailsScreen extends StatefulWidget {
  final ImageEntity image;

  const DetailsScreen({super.key, required this.image});

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.sizeOf(context).width,
          height: MediaQuery.sizeOf(context).height,
          child: Column(
            children: [
              SizedBox(
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height / 2,
                child: Stack(
                  children: [
                    SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height / 2,
                      child: CachedNetworkImage(
                        imageUrl: widget.image.url!,
                        fit: BoxFit.cover,
                      ),
                    ),
                    IconButton(
                      onPressed: () => Modular.to.pop(),
                      icon: Icon(
                        Icons.arrow_back,
                        color: Colors.white,
                        size: 50,
                      ),
                    )
                  ],
                ),
              ),
              Expanded(
                  child: ListView(
                    children: [
                      ListTile(
                        title: const Text("Título"),
                        subtitle: Text(widget.image.title!),
                      ),
                      ListTile(
                        title: const Text("Data"),
                        subtitle: Text(widget.image.date!),
                      ),
                      ListTile(
                        title: const Text("Detalhes", textAlign: TextAlign.justify,),
                        subtitle: Text(widget.image.explanation!),
                      )
                    ],
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
