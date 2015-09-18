part of suiml.handlers;

class ElementBuilder {
  Element _element;

  ElementBuilder(String tagName) {
    _element = new Element.tag(tagName);
  }

  ElementBuilder.fromElement(Element element) {
    _element = element;
  }

  ElementBuilder.copyFrom(Element element, String newElementTag) {
    _element = new Element.tag(newElementTag);
    copyAttributesFrom(element);
    setInnerHtmlFrom(element);
    replaceWith(element);
  }

  copyAttributesFrom(Element element) =>
  _element.attributes.addAll(element.attributes);

  setInnerHtmlFrom(Element element) => _element.innerHtml = element.innerHtml;

  addClasses(Iterable<String> classes) => _element.classes.addAll(classes);

  replaceWith(Element element) => element.replaceWith(_element);

  void addChild(ElementBuilder childBuilder(Element childElement),
                Element parentElement, String childElementTag) {
    var childElement = parentElement.children
    .firstWhere((x) => x.localName == childElementTag);
    if (childElement != null) {
      _element.children.add(childBuilder(childElement)._element);
    }
  }
}
