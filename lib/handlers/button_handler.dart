part of suiml.handlers;

class ButtonHandler extends Handler {
  _handleStandardButtons(Document document) {
    doForEach(document, "button", (e) {
      new ElementBuilder.fromElement(e)
        ..addClasses(["ui", "button"]);
    });
  }

  _handlePrimaryButtons(Document document) {
    doForEach(document, "button-primary", (e) {
      new ElementBuilder.copyFrom(e, "button")
        ..addClasses(["ui", "primary", "button"]);
    });
  }

  _handleSecondaryButtons(Document document) {
    doForEach(document, "button-secondary", (e) {
      new ElementBuilder.copyFrom(e, "button")
        ..addClasses(["ui", "secondary", "button"]);
    });
  }

  _handleAnimatedButtons(Document document) {
    doForEach(document, "button-animated", (element) {

      //todo: we need a CssClassBuilder.
      //this blocks add cssClass in following order.
      // ui animated button
      // ui vertical animated button
      // ui animated fade button
      var classes = ["ui"];
      if (element.attributes.containsKey("animation")) {
        var animationType = element.attributes["animation"];
        if (animationType.toLowerCase() == "vertical")
          classes.addAll(["vertical", "animated"]);
        else if (animationType.toLowerCase() == "fade")
          classes.addAll(["animated", "fade"]);

        //remove animation as it was only for the transformer.
        element.attributes.remove("animation");
      }
      else
        classes.add("animated");

      classes.add("button");

      new ElementBuilder("div")
        ..copyAttributesFrom(element)
        ..addClasses(classes)
        ..addChild((childElement) => (new ElementBuilder("div")
        ..addClasses(["visible", "content"])
        ..setInnerHtmlFrom(childElement)), element, "visible")
        ..addChild((childElement) => (new ElementBuilder("div")
        ..addClasses(["hidden", "content"])
        ..setInnerHtmlFrom(childElement)), element, "hidden")
        ..replaceWith(element);
    });
  }

  @override
  void handle(Document document) {
    _handleStandardButtons(document);
    _handlePrimaryButtons(document);
    _handleSecondaryButtons(document);
    _handleAnimatedButtons(document);
  }
}
