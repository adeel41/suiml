part of suiml.handlers;

class ButtonHandler extends Handler {
  @override
  void handle(Document document) {

    _addClassesForEach(document, "button", ["ui", "button"]);
    _replaceExistingButtonWith(document, "button-primary", ["ui", "primary", "button"]);
    _replaceExistingButtonWith(document, "button-secondary", ["ui", "secondary", "button"]);
    //_replaceExistingButtonWith(document, "button-animated")

    _doForEach(document, "button-animated", (element) {
      var updatedElement = new Element.tag("div");
      updatedElement.attributes.addAll(element.attributes);
      updatedElement.classes.addAll(["ui", "animated", "button"]);

      var visibleElement = _getChildNamed(element, "visible");
      var hiddenElement = _getChildNamed(element, "hidden");

      if (visibleElement != null) {
        var visibleContent = new Element.tag("div");
        visibleContent.classes.addAll(["visible", "content"]);
        visibleContent.innerHtml = visibleElement.innerHtml;
        updatedElement.children.add(visibleContent);
      }

      if (hiddenElement != null) {
        var hiddenContent = new Element.tag("div");
        hiddenContent.classes.addAll(["hidden", "content"]);
        hiddenContent.innerHtml = hiddenElement.innerHtml;
        updatedElement.children.add(hiddenContent);
      }

      element.replaceWith(updatedElement);

    });
  }

  Element _getChildNamed(Element element, String childName) {
    var result = element.children.where((x) => x.localName == childName);
    if (result.length > 0)
      return result.first;
    else
      return null;
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