import 'package:flube/src/helpers/fonts.dart';
import 'package:flube/src/providers/youtubeproviders.dart';
import 'package:flube/src/widgets/contentnotice.dart';
import 'package:flube/src/widgets/customfield.dart';
import 'package:flube/src/widgets/download_indicator.dart';
import 'package:flube/src/widgets/filtercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flube/src/helpers/enum.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _url = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    print('jdjbd');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Yotube Video Downloader',
          style: nStyle.copyWith(color: Colors.white),
        ),
        centerTitle: true,
      ),
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 50),
            UrlField(
              formkey: _formKey,
              url: _url,
              hint: 'Enter Valid Youtube Url',
            ),
            const SizedBox(height: 30),
            FlubeButton(function: (){
              buttonAction();
            }),
            const SizedBox(height: 30),
           FilterCard(),
          // DownLoadPercentIndicator(),
            const SizedBox(height: 30),
          //  ContentNotice()
          ],
        ),
      ),
    );
  }

  buttonAction() {
    print('gg');
    if (_validateAndSave()!) {
      print(_url.text);
      context.read(youtubeVideoProvider).getVideoDetails(_url.text);
    }
  }

  bool? _validateAndSave() {
    final form = _formKey.currentState;
    if (form!.validate()) {
      form.save();
      return true;
    }
    return false;
  }
}

class FlubeButton extends ConsumerWidget {
  const FlubeButton({
    Key? key,
    required this.function
  }) : super(key: key);
  final Function()? function;
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final status = watch(youtubeVideoProvider);
    return  ElevatedButton(
            onPressed:  status.status == Status.start? (){} : function,
            child: status.status == Status.start
        ?  CircularProgressIndicator(
              color: Colors.white,
            ) : Text(
              'Enter',
              style: nStyle.copyWith(color: Colors.white, fontSize: 20),
            )
          );
  }
}
