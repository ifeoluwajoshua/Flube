import 'dart:io';

import 'package:downloads_path_provider_28/downloads_path_provider_28.dart';
import 'package:flube/src/helpers/enum.dart';
import 'package:flube/src/models/youtube_details.dart';
import 'package:flube/src/providers/youtubeproviders.dart';
import 'package:flube/src/widgets/toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path/path.dart' as path;
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class YoutubeDownloader extends ChangeNotifier {
  final Reader _read;
  YoutubeDownloader(this._read);
  // Declaration
  Status _status = Status.initial;
  
  Video? _videodetails;
  VideoDetails? _details;
  double _count = 0;
  var datalength;
  // Get Dclaration
  get count => _count;
  VideoDetails? get details => _details;
  Status get status => _status;


  Future getVideoDetails(String url) async {
    print('Getting Video Details');
    // Getting Video Details
    _details = null;
    _status = Status.start;
    notifyListeners();
    try {
      var id = VideoId(url.trim());
      _videodetails = await _read(youtube).videos.get(id);
      var manifest = await _read(youtube).videos.streamsClient.getManifest(id);
      var video = manifest.muxed.last;
      var audio = manifest.audioOnly.last;
      //audio.bitrate;
      var videoLength = video.size.totalBytes;
      var auidoLength = audio.size.totalBytes;

      print(_videodetails!.thumbnails);
      print(_videodetails!.title);
      print(video.videoQualityLabel);
      print(video.videoQuality);
      print(video.videoCodec);
      print(video.videoResolution);
      print(video.size);
      print(audio.size);

      _details = VideoDetails(
          _videodetails!.title,
          video.videoQualityLabel.toString(),
          audio.bitrate.toString(),
          video.size.totalMegaBytes.toStringAsFixed(0),
          audio.size.totalBytes.toString(),
          video,
          videoLength,
          auidoLength);
      notifyListeners();
      print('Done Getting');

      print('Finished Getting Details Service');
    } on SocketException {
      print('netwoek error');
      showToast('Network error, Check your network and try again');
    } catch (e) {
      print('errror that just happened is $e');
      showToast('Big error');
    }
     _status = Status.end;
    notifyListeners();
  }

  Future downloadVideo(MuxedStreamInfo video, var len) async {
    print('Taking Permission');
    //Handling  Permission

    bool gotten = await _read(permissionProvider).askPermissions();

    if (gotten) {
      // Build Directory
      print('Buildinig Directory');
      var dir = await DownloadsPathProvider.downloadsDirectory;
      var filePath = path.join(dir!.uri.toFilePath(),
          '${_videodetails!.title}.${video.container.name}');

      // Open the file to write.
      print('Opening File');
      var file = File(filePath);
      var fileStream = file.openWrite();
      // Download Video
      print('Downloading');
      var videodonwloading = _read(youtube).videos.streamsClient.get(video);

      await for (var data in videodonwloading) {
        datalength += data.length.toDouble();
        _count = ((datalength / len) * 100).ceil();
        notifyListeners();
        print('a $count');
        print('b $_count');
        fileStream.add(data);
      }
      // Close instance of the file

      await fileStream.flush();
      await fileStream.close();
      print('Done Downloading and Saving');
    } else {
      await showToast('Storage Permission Denied');
    }
  }

  Future downloadAudio() async {}
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
