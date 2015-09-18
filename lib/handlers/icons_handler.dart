part of suiml.handlers;

class IconsHandler extends Handler {
  @override
  void handle(Document document) {
    _replaceIcon(document, "icon-right-arrow", ["right", "arrow", "icon"]);
    _replaceIcon(document, "icon-shop", ["shop", "icon"]);
  }

  void _replaceIcon(Document document, String suiTag, Iterable<String> classes) {
    doForEach(document, suiTag, (element) {
      new ElementBuilder("i")
        ..addClasses(classes)
        ..replaceWith(element);
    });

  }
}