part of suiml.handlers;

class CommonAttributesHandler extends Handler {
  @override
  void handle(Document document) {
    for (var element in document.querySelectorAll("[focus]")) {
      element.attributes.remove("focus");
      element.attributes.addAll({"tabindex": "0"});
    }
  }
}