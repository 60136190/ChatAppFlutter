String defaultReplacementToken;
List<String> moodStatus;
List<String> userStatus;
List<String> chatMessage;
List<String> messageTemplate;
List<String> keijibanPost;
List<String> favoritePlace;
List<String> firstDateLocation;
List<String>  ngWordsList;

void initFromAPIData(Map<String, dynamic> apiData) {
  defaultReplacementToken = apiData['data']['ng_words_replace'];
  final ngWords = apiData['data']['ng_words']['result'];
  try {
    ngWordsList = List<String>.from(ngWords);
    // moodStatus = List<String>.from(ngWords[0]);
    // userStatus = List<String>.from(ngWords[1]);
    // chatMessage = List<String>.from(ngWords[2]);
    // messageTemplate = List<String>.from(ngWords[3]);
    // keijibanPost = List<String>.from(ngWords[4]);
    // favoritePlace = List<String>.from(ngWords[5]);
    // firstDateLocation = List<String>.from(ngWords[6]);
  } on RangeError catch (_, st) {
    print('WARNING: Missing NG word categories');
    print(st);
  }
}

bool check(String phrase, List<String> wordlist) {
  if (phrase != null && wordlist != null && wordlist.isNotEmpty)
    for (final word in wordlist)
      if (phrase.contains(word))
        return true;
  return false;
}

String filter(String phrase, List<String> wordlist) {
  if (phrase != null && wordlist != null && wordlist.isNotEmpty) {
    String replaceText = phrase;
    for (String word in wordlist) {
      replaceText = replaceText.replaceAll(word,defaultReplacementToken);
    }
    return replaceText;
  } else {
    return phrase;
  }
}