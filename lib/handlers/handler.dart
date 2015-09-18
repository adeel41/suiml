part of suiml.handlers;

abstract class Handler {
  void handle(Document document);
  void doForEach(
      Document document, String selector, void action(Element element)) {
    for (var element in document.querySelectorAll(selector)) {
      action(element);
    }
  }
}
