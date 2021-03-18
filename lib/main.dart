import 'package:dynamic_links_test/hello_world.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

main() {
  runApp(
    MaterialApp(
      routes: {
        '/': (context) => MainPage(),
        '/helloworld': (context) => HelloWorld('linkData'),
      },
    ),
  );
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  void initState() {
    super.initState();
    this.initDynamicLinks();
  }

  void initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      print(deepLink.queryParameters);

      if (deepLink != null) {
        Navigator.pushNamed(context, '/${deepLink.queryParameters['route']}');
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      Navigator.pushNamed(context, deepLink.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    _generateDynamicLink();
    return Scaffold();
  }

  Future<void> _generateDynamicLink() async {
    DynamicLinkParameters params = DynamicLinkParameters(
      uriPrefix: 'wolfiz.page.link',
      link: Uri.parse('https://wolfiz.page.link/hello_world?name=Faizan'),
      androidParameters: AndroidParameters(
        packageName: 'com.wolfiz.dynamic_links_test',
        minimumVersion: 0,
      ),
    );
    print((await params.buildUrl()).toString());
  }
}
