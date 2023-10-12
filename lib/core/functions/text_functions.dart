class TextFunctions {
  String toShow(String text) {
    List<String> bedStatus = text.split("_");

    String bedStatusFinal = " ";
    for (int i = 0; i < bedStatus.length; i++) {
      bedStatusFinal += "${bedStatus[i]} ";
    }

    return bedStatusFinal;
  }
}
