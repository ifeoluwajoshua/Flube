import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class VideoDetails {
  VideoDetails(this.title, this.videoQuality, this.audioBitrate, this.videoSize,
      this.audioSize, this.video,this.audio, this.videoLength, this.audioLength);

  String title;
  String videoQuality;
  String audioBitrate;
  String videoSize;
  String audioSize;
  MuxedStreamInfo video;
  AudioOnlyStreamInfo audio;
  var videoLength;
  var audioLength;
  
  @override
  String toString() =>
      '- $title,\n- $videoQuality\n- $audioBitrate\n- $videoSize\n- $audioSize';
}
