part of suiml.handlers;

class ButtonHandler extends Handler {
  @override
  void handle(Document document) {

    _addClassesForEach(document, "button", ["ui", "button"]);
    _replaceExistingButtonWith(document, "button-primary", ["ui", "primary", "button"]);
    _replaceExistingButtonWith(document, "button-secondary", ["ui", "secondary", "button"]);
  }

  void _replaceExistingButtonWith(Document document, String selector, List<String> classes) {
    _doForEach(document, selector, (btn) {
      var updatedButton = _copyFrom(btn, "button");
      updatedButton.classes.addAll(classes);
      btn.replaceWith(updatedButton);
    });
  }


  Element _copyFrom(Element element, String newElementTag) {
    var newElement = new Element.tag(newElementTag);
    newElement.attributes.addAll(element.attributes);
    newElement.innerHtml = element.innerHtml;

    return newElement;
  }

  void _doForEach(Document document, String selector, void action(Element element)) {
    for (var element in document.querySelectorAll(selector)) {
      action(element);
    }
  }

  void _addClassesForEach(Document document, String selector, List<String> classes) => _doForEach(document, selector, (e) => e.classes.addAll(classes));
}