class StringUtil {
  static bool isNullOrEmpty(String str) {
    return str == null || str.length <= 0;
  }

  static String strClean(String str) {
    return str
        .replaceAll(RegExp("(<em[^>]*>)|(</em>)"), "")
        .replaceAll(RegExp("\n{2,}"), "\n")
        .replaceAll(RegExp("\s{2,}"), " ")
        .replaceAll("&ndash;", "–")
        .replaceAll("&mdash;", "—")
        .replaceAll("&lsquo;", "‘")
        .replaceAll("&rsquo;", "’")
        .replaceAll("&sbquo;", "‚")
        .replaceAll("&ldquo;", "“")
        .replaceAll("&rdquo;", "”")
        .replaceAll("&bdquo;", "„")
        .replaceAll("&permil;", "‰")
        .replaceAll("&lsaquo;", "‹")
        .replaceAll("&rsaquo;", "›")
        .replaceAll("&euro;", "€")
        .replaceAll("<p>", "")
        .replaceAll("</p>", "")
        .replaceAll("</br>", "\n")
        .replaceAll("<br>", "\n")
        .replaceAll("&lt;", "<")
        .replaceAll("&gt;", ">")
        .replaceAll("&nbsp;", " ")
        .replaceAll("&amp;", "&")
        .replaceAll("&quot;", "\"")
        .replaceAll("&yen;", "¥");
  }
}
