import 'package:flube/src/helpers/colors.dart';
import 'package:flube/src/helpers/fonts.dart';
import 'package:flube/src/helpers/responsive.dart';
import 'package:flube/src/models/youtube_details.dart';
import 'package:flube/src/providers/youtubeproviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FilterCard extends ConsumerWidget {
  const FilterCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final video = watch(youtubeVideoProvider);
    VideoDetails? videodetails = video.details;

    return videodetails != null
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Text(
                  'Download Below',
                  style: nStyle.copyWith(
                      fontSize: SizeConfig.textSize(context, 4),
                      fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 30),
              RichText(
                text: TextSpan(
                  text: 'Title: ',
                  style: nStyle.copyWith(
                      // backgroundColor: Colors.grey.shade100,
                      fontSize: SizeConfig.textSize(context, 4),
                      fontWeight: FontWeight.w500),
                  children: <TextSpan>[
                    TextSpan(
                      text: videodetails.title,
                      style: nStyle.copyWith(
                          backgroundColor: Colors.grey.shade100,
                          fontSize: SizeConfig.textSize(context, 3.5),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Container(
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  // height: 250,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: shadowColor),
                    color: Colors.white30,
                  ),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        qualityFilter(
                            context,
                            'Video',
                            videodetails.videoQuality,
                            videodetails.videoSize, () {
                          print(' Video');
                          context.read(youtubeVideoProvider).downloadVideo(
                              videodetails.video, videodetails.videoLength);
                        }),
                        filterDivider(context),
                        qualityFilter(
                            context,
                            'Audio',
                            videodetails.audioBitrate,
                            videodetails.audioSize, () {
                          print(' Audio');
                          context.read(youtubeVideoProvider).downloadAudio();
                        }),
                      ])),
            ],
          )
        : SizedBox.shrink();
  }

  Widget qualityFilter(
      context, String type, String quality, String size, Function() fun) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        type,
        style: nStyle.copyWith(
            backgroundColor: Colors.grey.shade100,
            fontSize: SizeConfig.textSize(context, 3.7),
            fontWeight: FontWeight.w700),
      ),
      Text(
        quality,
        style: nStyle.copyWith(
            backgroundColor: Colors.grey.shade100,
            fontSize: SizeConfig.textSize(context, 3.7),
            fontWeight: FontWeight.w400),
      ),
      Text(
        size,
        style: nStyle.copyWith(
            backgroundColor: Colors.grey.shade100,
            fontSize: SizeConfig.textSize(context, 3.7),
            fontWeight: FontWeight.w400),
      ),
      ElevatedButton(
        onPressed: fun,
        child: Text(
          'Download',
          style: nStyle.copyWith(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    ]);
  }

  Widget filterDivider(context) {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 100) * 40,
      child: Divider(
        height: 20,
        thickness: 1,
        color: mColor,
      ),
    );
  }
}
