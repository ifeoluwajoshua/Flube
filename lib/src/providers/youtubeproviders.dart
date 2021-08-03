import 'package:flube/src/services/permission.dart';
import 'package:flube/src/services/video_downloader.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

final youtube = Provider((ref) => YoutubeExplode());

final permissionProvider =
    Provider<StoragePermission>((ref) => StoragePermission());

final youtubeVideoProvider = ChangeNotifierProvider<YoutubeDownloader>(
    (ref) => YoutubeDownloader((ref.read)));


