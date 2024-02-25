import 'package:Trackefi/core/presentation/ui/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TrEditableText extends StatefulWidget {
  final String text;
  final Function(String)? onChanged;
  const TrEditableText({
    Key? key,
    required this.text,
    this.onChanged,
  }) : super(key: key);

  @override
  State<TrEditableText> createState() => _EditableTextState();
}

class _EditableTextState extends State<TrEditableText> {
  bool editing = false;
  TextEditingController textFieldController = TextEditingController();
  String visibleText = '';

  @override
  void initState() {
    textFieldController.text = widget.text;
    visibleText = widget.text;
    super.initState();
  }

  @override
  void didUpdateWidget(covariant TrEditableText oldWidget) {
    visibleText = widget.text;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () => setState(() {
        editing = true;
      }),
      child: editing
          ? CallbackShortcuts(
              bindings: <ShortcutActivator, VoidCallback>{
                const SingleActivator(LogicalKeyboardKey.escape): () =>
                    _cancel(),
                const SingleActivator(LogicalKeyboardKey.enter): () {
                  if (widget.onChanged != null) {
                    widget.onChanged!(textFieldController.text);
                  }
                  setState(() {
                    editing = false;
                  });
                },
              },
              child: Row(
                children: [
                  SizedBox(
                    width: 250,
                    child: TrTextField(
                      autofocus: true,
                      controller: textFieldController,
                    ),
                  ),
                  IconButton(
                      onPressed: () => _cancel(), icon: const Icon(Icons.close))
                ],
              ),
            )
          : Text(
              visibleText,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
    );
  }

  _cancel() {
    textFieldController.text = widget.text;
    setState(() {
      editing = false;
    });
  }
}
