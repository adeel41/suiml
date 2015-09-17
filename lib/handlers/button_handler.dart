part of suiml.handlers;

class ElementBuilder {
  Element _element;


  ElementBuilder(String tagName) {
    _element = new Element.tag(tagName);
  }

  ElementBuilder.fromElement(Element element)
  {
    _element = element;
  }

  ElementBuilder.copyFrom(Element element, String newElementTag)
  {
    _element = new Element.tag(newElementTag);
    copyAttributesFrom(element);
    _element.innerHtml = element.innerHtml;
    element.replaceWith(_element);
  }

  void copyAttributesFrom(Element element) => _element.attributes.addAll(element.attributes);

  void addClasses(Iterable<String> classes) => _element.classes.addAll(classes);
}

class ButtonHandler extends Handler {

  _handleStandardButtons(Document document) {
    _doForEach(document, "button", (e) {
      new ElementBuilder.fromElement(e)
        ..addClasses(["ui", "button"]);
    });
  }

  _handlePrimaryButtons(Document document) {
    _doForEach(document, "button-primary", (e) {
      new ElementBuilder.copyFrom(e, "button")
        ..addClasses(["ui", "primary", "button"]);
    });
  }

  _handleSecondaryButtons(Document document) {
    _doForEach(document, "button-secondary", (e) {
      new ElementBuilder.copyFrom(e, "button")
        ..addClasses(["ui", "secondary", "button"]);
    });
  }

  _handleAnimatedButtons(Document document) {
    _doForEach(document, "button-animated", (element) {
      var animatedButton = new ElementBuilder("div")
        ..copyAttributesFrom(element)
        ..addClasses(["ui", "animated", "button"]);

   //   var visibleSection = new ElementBuilder("div")
 //     ..addClasses(["visible", "content"])
      //..SetInnerHtmlOf(el)

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

  @override
  void handle(Document document) {

    _handleStandardButtons(document);
    _handlePrimaryButtons(document);
    _handleSecondaryButtons(document);
    _handleAnimatedButtons(document);

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
/*
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

  void _addClassesForEach(Document document, String selector, List<String> classes) => _doForEach(document, selector, (e) => e.classes.addAll(classes));
*/

  void _doForEach(Document document, String selector, void action(Element element)) {
    for (var element in document.querySelectorAll(selector)) {
      action(element);
    }
  }
}