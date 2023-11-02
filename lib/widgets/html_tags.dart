import 'package:html_rich_text/widgets/html_token.dart';

enum HtmlTags {
  bold('b'),
  hyperlink('a'),
  italic('i'),
  list('li'),
  none(''),
  underline('u'),
  endBold('b'),
  endHyperlink('a'),
  endItalic('i'),
  endList('li'),
  endUnderline('u');

  final String tag;
  const HtmlTags(this.tag);

  static List<Token> parseHtmlLikeString(String input) {
    List<Token> tokens = [];
    final tagRegex = RegExp(r'(<(/?)(a|b|li|i|u)>([^<]*))');
    final matches = tagRegex.allMatches(input);

    int lastMatchEnd = 0;

    for (var match in matches) {
      String tagName = match.group(3) ?? '';
      bool isClosingTag = match.group(2) == '/';
      String tagContent = match.group(4) ?? '';

      // Capture text before the tag, if any
      if (match.start > lastMatchEnd) {
        String textBeforeTag = input.substring(lastMatchEnd, match.start);
        if (textBeforeTag.isNotEmpty) {
          tokens.add(Token(content: textBeforeTag, tag: HtmlTags.none));
        }
      }
      lastMatchEnd = match.end;

      // Determine the tag type
      HtmlTags tag = HtmlTags.none;
      switch (tagName) {
        case 'a':
          tag = isClosingTag ? HtmlTags.endHyperlink : HtmlTags.hyperlink;
          break;
        case 'b':
          tag = isClosingTag ? HtmlTags.endBold : HtmlTags.bold;
          break;
        case 'li':
          tag = isClosingTag ? HtmlTags.endList : HtmlTags.list;
          break;
        case 'i':
          tag = isClosingTag ? HtmlTags.endItalic : HtmlTags.italic;
          break;
        case 'u':
          tag = isClosingTag ? HtmlTags.endUnderline : HtmlTags.underline;
          break;
      }

      tokens.add(Token(content: tagContent, tag: tag));
    }

    // Capture any remaining text after the last match
    if (lastMatchEnd < input.length) {
      String remainingText = input.substring(lastMatchEnd);
      if (remainingText.isNotEmpty) {
        tokens.add(Token(content: remainingText, tag: HtmlTags.none));
      }
    }

    return tokens;
  }

  HtmlTags tagFor(String name, bool isClosingTag) {
    switch (name) {
      case 'b':
        return isClosingTag ? HtmlTags.endBold : HtmlTags.bold;
      case 'i':
        return isClosingTag ? HtmlTags.endItalic : HtmlTags.italic;
      case 'li':
        return isClosingTag ? HtmlTags.endList : HtmlTags.list;
      case 'u':
        return isClosingTag ? HtmlTags.endUnderline : HtmlTags.underline;
      case 'a':
        return isClosingTag ? HtmlTags.endList : HtmlTags.hyperlink;
      default:
        return HtmlTags.none;
    }
  }
}
