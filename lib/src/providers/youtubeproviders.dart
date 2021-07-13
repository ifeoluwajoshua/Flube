import 'package:flube/src/providers/shared.dart';
import 'package:flube/src/services/downloader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final youtubeVideoProvider = Provider((ref) => YoutubeDownloader());

final youtubeDetailsProvider = FutureProvider<dynamic>((ref) async {
  final detailsProvider = ref.read(youtubeVideoProvider);
  return detailsProvider.getVideoDetails('url');
});

final youtubeDownloader = FutureProvider<dynamic>((ref) async {
 final permission = ref.read(permissionProvider);
 //Switch permission.state;

});
