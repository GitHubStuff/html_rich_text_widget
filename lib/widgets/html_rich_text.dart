import 'package:flutter/material.dart';
import 'package:html_rich_text/widgets/html_tags.dart';
import 'package:html_rich_text/widgets/html_token.dart';

class HtmlRichText extends StatelessWidget {
  final List<Token> tokens;
  final TextStyle? textStyle;
  final Color linkColor;

  const HtmlRichText({
    super.key,
    required this.tokens,
    this.textStyle,
    this.linkColor = Colors.green,
  });

  factory HtmlRichText.fromString(
    String input, {
    TextStyle? textStyle,
    Color linkColor = Colors.green,
  }) {
    List<Token> tokens = HtmlTags.parseHtmlLikeString(input);
    return HtmlRichText(
      tokens: tokens,
      textStyle: textStyle,
      linkColor: linkColor,
    );
  }

  @override
  Widget build(BuildContext context) {
    List<TextSpan> spans = [];
    TextStyle style = textStyle ?? const TextStyle();
    Color textColor = style.color ?? Colors.black;

    for (var token in tokens) {
      switch (token.tag) {
        case HtmlTags.bold:
          style = style.copyWith(fontWeight: FontWeight.bold);
          break;
        case HtmlTags.hyperlink:
          style = style.copyWith(color: linkColor);
          break;
        case HtmlTags.italic:
          style = style.copyWith(fontStyle: FontStyle.italic);
          break;
        case HtmlTags.list:
          token.content = '\n${token.content}';
          break;
        case HtmlTags.underline:
          style = style.copyWith(decoration: TextDecoration.underline);
          break;
        case HtmlTags.endBold:
          style = style.copyWith(fontWeight: FontWeight.normal);
          break;
        case HtmlTags.endHyperlink:
          style = style.copyWith(color: textColor);
          break;
        case HtmlTags.endList:
          break;
        case HtmlTags.endItalic:
          style = style.copyWith(fontStyle: FontStyle.normal);
          break;
        case HtmlTags.endUnderline:
          style = style.copyWith(decoration: TextDecoration.none);
          break;
        case HtmlTags.none:
          style = textStyle ?? const TextStyle();
          break;
      }
      spans.add(TextSpan(text: token.content, style: style));
    }

    return RichText(
      text: TextSpan(
        style: DefaultTextStyle.of(context).style,
        children: spans,
      ),
    );
  }
}
