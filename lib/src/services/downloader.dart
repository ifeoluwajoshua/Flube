import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader {
  // Declaration
  Video? _videodetails;

  var youtube = YoutubeExplode();

  Future getVideoDetails(String url) async {
    print('Getting Video Details');
    var result;
    // Getting Video Details
    var id = VideoId(url.trim());
    _videodetails = await youtube.videos.get(id);
    var manifest = await youtube.videos.streamsClient.getManifest(id);
    var video = manifest.muxed;
    result = {'details': _videodetails, 'video': video};
    print('Done Getting');
    return result;
  }

  Future downloadVideo(Video videod, MuxedStreamInfo video) async {
    print('Buildinig Directory');
    // Build Directory
    var dir = await DownloadsPathProvider.downloadsDirectory;
    var filePath = path.join(
        dir!.uri.toFilePath(), '${videod.id}.${video.container.name}');

    // Open the file to write.
    print('Opening File');
    var file = File(filePath);
    var fileStream = file.openWrite();

    // Download Video
    print('Downloading');
    await youtube.videos.streamsClient.get(video).pipe(fileStream);

// Close instance of the file

    await fileStream.flush();
    await fileStream.close();
    print('Done Downloading and Saving');
  }
}

downloadVideo(BuildContext context, String url) async {
  // Here you should validate the given input or else an error
  // will be thrown.
  print('Starting');
  var yt = YoutubeExplode();
  var id = VideoId(url.trim());
  var video = await yt.videos.get(id);

  // Display info about this video.
  await showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: Text('Title: ${video.title}, Duration: ${video.duration}'),
      );
    },
  );

  // Request permission to write in an external directory.
  // (In this case downloads)

  // Get the streams manifest and the audio track.
  var manifest = await yt.videos.streamsClient.getManifest(id);
  var vidd = manifest.muxed.last;
  var audio = manifest.video;
  print(audio);
  print(manifest.muxed.map((e) => e.videoQualityLabel));
  print(manifest.streams);
  print(vidd.videoQuality);
  print(vidd.videoResolution);
  // Build the directory.
  var dir = await DownloadsPathProvider.downloadsDirectory;
  var filePath =
      path.join(dir!.uri.toFilePath(), '${video.id}.${vidd.container.name}');

  // Open the file to write.
  var file = File(filePath);
  var fileStream = file.openWrite();

  // Pipe all the content of the stream into our file.
  await yt.videos.streamsClient.get(vidd).pipe(fileStream);
  /*
                  If you want to show a % of download, you should listen
                  to the stream instead of using `pipe` and compare
                  the current downloaded streams to the totalBytes,
                  see an example ii example/video_download.dart
                   */

  // Close the file.
  await fileStream.flush();
  await fileStream.close();

  // Show that the file was downloaded.
  await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Text('Download completed and saved to: $filePath'),
        );
      });
}
