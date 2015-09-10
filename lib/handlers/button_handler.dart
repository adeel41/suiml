part of suiml.handlers;

class ButtonHandler extends Handler {
  @override
  void handle(Document document) {

    _addClassesForEach(document, "button", ["ui", "button"]);

    for (var btn in document.querySelectorAll("button-primary")) {
      var updatedButton = new Element.tag("button");
      updatedButton.attributes.addAll(btn.attributes);
      updatedButton.classes.addAll(["ui", "primary", "button"]);
      updatedButton.innerHtml = btn.innerHtml;

      btn.replaceWith(updatedButton);
    }
  }

  void _doForEach(Document document, String selector, void action(Element element)) {
    for (var element in document.querySelectorAll(selector)) {
      action(element);
    }
  }

  void _addClassesForEach(Document document, String selector, List<String> classes) => _doForEach(document, selector, (e) => e.classes.addAll(classes));


}