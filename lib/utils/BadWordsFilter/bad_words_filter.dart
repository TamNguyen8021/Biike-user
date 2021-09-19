import 'package:bikes_user/utils/BadWordsFilter/bad_word_list/bad_word_en.dart';
import 'package:bikes_user/utils/BadWordsFilter/bad_word_list/bad_word_vi.dart';

class BadWordsFilter {
  List<String> filteredWordsList = [];

  BadWordsFilter() {
    this.filteredWordsList = [
      ...badWordsListEn,
      ...badWordsListVi
    ];
  }

  bool hasBadWords(String s) {
    for (var word in this.filteredWordsList) {
      if (s.toLowerCase().split(' ').contains(word)) {
        return true;
      }
    }

    return false;
  }

  String censor(String inputString, {String? replaceString}) {
    List<String> inputStringSoup = inputString.split(' ');

    this.filteredWordsList.forEach((word) {
      if (replaceString == null) {
        for (int i = 0; i < inputStringSoup.length; i++) {
          if (inputStringSoup[i].toLowerCase() == word) {
            inputStringSoup[i] = '*' * word.length;
          }
        }
      } else {
        for (int i = 0; i < inputStringSoup.length; i++) {
          if (inputStringSoup[i].toLowerCase() == word) {
            inputStringSoup[i] = replaceString;
          }
        }
      }
    });
    return inputStringSoup.join(' ');
  }
}