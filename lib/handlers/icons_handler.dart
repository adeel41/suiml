part of suiml.handlers;

class IconsHandler extends Handler {
  @override
  void handle(Document document) {
    for (var element in document.querySelectorAll("icon-right-arrow")) {
      var iconElement = new Element.tag("i");
      iconElement.classes.addAll(["right", "arrow", "icon"]);
      element.replaceWith(iconElement);
    }
  }
}