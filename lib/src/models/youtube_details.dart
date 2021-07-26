

class VideoDetails {
  VideoDetails(this.title, this.videoQuality,this.audioBitrate, this.videoSize,this.audioSize);
  String title;
  String videoQuality;
  String audioBitrate;
  String videoSize;
  String audioSize;

  @override
  String toString() => '- $title,\n- $videoQuality\n- $audioBitrate\n- $videoSize\n- $audioSize';
}
