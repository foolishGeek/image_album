import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_album/core/di/di.dart';
import 'package:image_album/core/utility/app_init.dart';
import 'package:image_album/data/images_album/repository/image_album_repository.dart';
import 'package:image_album/domain/image_album/usecase/get_album_use_case.dart';
import 'package:image_album/domain/image_album/usecase/get_images_use_case.dart';
import 'package:image_album/presentation/image_album/bloc/image_album_bloc.dart';
import 'package:image_album/presentation/image_album/screens/album_images.dart';

void main() async {
  //Initialisation
  runZonedGuarded(() async {
    await InitialiseApp().init();

    runApp(const MyApp());
  }, _onError);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Album Images',
      home: BlocProvider(
        create: (_) {
          injectImageAlbumsDependency();
          return ImageAlbumBloc(
              getAlbums: di<GetAlbumUseCase>(),
              getImages: di<GetImagesUseCase>());
        },
        child: const AlbumImagesScreen(),
      ),
    );
  }
}

void _onError(Object object, StackTrace stack) {
  throw Exception('Object: $object, stack: $stack');
}


