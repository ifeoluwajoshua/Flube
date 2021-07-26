import 'package:flube/src/helpers/fonts.dart';
import 'package:flube/src/providers/youtubeproviders.dart';
import 'package:flube/src/widgets/contentnotice.dart';
import 'package:flube/src/widgets/customfield.dart';
import 'package:flube/src/widgets/filtercard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


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
            enterButton(),
            const SizedBox(height: 30),
            FilterCard(),
             const SizedBox(height: 30),
            ContentNotice()
          ],
        ),
      ),
    );
  }

  Widget enterButton() {
    return ElevatedButton(
      onPressed: () {
        print('gg');
        if (_validateAndSave()!) {
          print(_url.text);
          context.read(youtubeDetailsProvider(_url.text));
        }
      },
      child: Text(
        'Enter',
        style: nStyle.copyWith(color: Colors.white, fontSize: 20),
      ),
    );
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
