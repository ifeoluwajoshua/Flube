import 'package:flube/src/providers/youtubeproviders.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DownLoadPercentIndicator  extends ConsumerWidget {
  const DownLoadPercentIndicator ({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
   final percent = watch(youtubeVideoProvider);
    final count = percent.count.toStringAsFixed(1);
    return CircularPercentIndicator(
                  radius: 50.0,
                  lineWidth: 5.0,
                  percent: percent.count,
                  center: new Text('7', style: TextStyle(fontWeight: FontWeight.w600)),
                  progressColor: Colors.orange,
                );
  }
}