import 'dart:async';
import 'package:barback/barback.dart';
import 'package:suiml/handlers/handlers.dart';
import 'package:html/dom.dart';

class SuimlTransformer extends Transformer {
  @override
  String get allowedExtensions => ".html";

  SuimlTransformer.asPlugin();

  @override
  Future apply(Transform transform) async{
    var content = await transform.primaryInput.readAsString();
    var id = transform.primaryInput.id;

    var document = new Document.html(content);
    new ButtonHandler().handle(document);

    var newContent = document.outerHtml;
    transform.addOutput(new Asset.fromString(id, newContent));
  }
}