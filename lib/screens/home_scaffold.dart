// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:html_rich_text/widgets/html_rich_text.dart';

class HomeScaffold extends StatelessWidget {
  const HomeScaffold({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: homeWidget(context),
      floatingActionButton: null,
    );
  }

  Widget homeWidget(BuildContext context) {
    const String html =
        'Some html\n<a>link</a>\n<b>bold</b>\n<i>Italic</i>\n<u>underline</u>\nfor testing';
    const String list =
        'A list<li>Dog <i>woof</i></li><li>Cat <b>meow</b></li><li>Bird <i><b>Chirp <u>Chirp</u> Cheep</b> Worm!</i></li>';

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Sample'),
          HtmlRichText.fromString(
            html,
            textStyle: const TextStyle(fontSize: 17.0),
          ),
          HtmlRichText.fromString(
            list,
            textStyle: const TextStyle(fontSize: 17.0),
          ),
        ],
      ),
    );
  }
}
