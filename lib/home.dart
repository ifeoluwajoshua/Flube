import 'package:flube/src/helpers/colors.dart';
import 'package:flube/src/helpers/fonts.dart';
import 'package:flube/src/helpers/validators.dart';
import 'package:flube/src/widgets/customfield.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _url = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _key = GlobalKey<ScaffoldState>();

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
      resizeToAvoidBottomInset: false,1
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 30),
            Form(
                key: _formKey,
                child: customField(_url, validateN, 'Enter Valid Youtube Url')),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () {
                print('gg');
                if (_validateAndSave()!) {
                  print(_url.text);
                }
              },
              child: Text(
                'Enter',
                style: nStyle.copyWith(color: Colors.white, fontSize: 20),
              ),
            ),
            const SizedBox(height: 40),
            Text(
              'Choose Quality: ',
              style: nStyle.copyWith(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
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
                      qualityFilter(),
                      filterDivider(),
                      qualityFilter(),
                      filterDivider(),
                      qualityFilter(),
                      filterDivider(),
                      qualityFilter(),
                    ]))
          ],
        ),
      ),
    );
  }

  Widget qualityFilter() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      Text(
        '720Mp',
        style: nStyle.copyWith(
            backgroundColor: Colors.grey.shade100,
            fontSize: 20,
            fontWeight: FontWeight.w400),
      ),
      ElevatedButton(
        onPressed: () {
          print('Downloaded');
        },
        child: Text(
          'Download',
          style: nStyle.copyWith(
              color: Colors.white, fontSize: 15, fontWeight: FontWeight.w400),
        ),
      ),
    ]);
  }

  Widget filterDivider() {
    return SizedBox(
      width: (MediaQuery.of(context).size.width / 100) * 30,
      child: Divider(
        height: 20,
        thickness: 1,
        color: mColor,
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
