import 'package:flashcard/flash_card/flashcard.dart';

class FlashCardSets{
    String name;
    List<flashCard> flashCardList;
    void addFlashCard(flashCard card){
      flashCardList.add(card);
    }

    int getsetSize(){
      return flashCardList.length;
    }

    FlashCardSets(String name, List<flashCard> list){
      this.name = name;
      this.flashCardList = list;
    }

}

