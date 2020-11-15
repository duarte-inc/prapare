import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prapare/models/fhir_questionnaire/survey/export.dart';

class AnswerItemString extends StatefulWidget {
  const AnswerItemString(
      {Key key,
      @required this.answer,
      @required this.rxUserResponse,
      bool isMultiLine})
      : _isMultiLine = isMultiLine ?? false,
        assert(answer != null),
        assert(rxUserResponse != null),
        super(key: key);

  final Answer answer;
  final Rx<UserResponse> rxUserResponse;
  final bool _isMultiLine;

  @override
  _AnswerItemStringState createState() => _AnswerItemStringState();
}

class _AnswerItemStringState extends State<AnswerItemString> {
  TextEditingController _textEditingController;
  final RxString _obj = ''.obs;

  @override
  Widget build(BuildContext context) {
    // todo: handle item entry + debounce
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: TextField(
        controller: _textEditingController,
        onChanged: (newValue) => _obj.value = newValue,
        minLines: widget._isMultiLine ? 3 : 1,
        maxLines: widget._isMultiLine ? 6 : 1,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'answer: string',
        ),
      ),
    );
  }

  @override
  void initState() {
    _textEditingController = TextEditingController(
        text: widget.rxUserResponse.value.responseType.value);
    // after 1 second, store this new text in rxUserResponse
    // todo: change location of where it's stored in rxUserResponse
    debounce(_obj, (value) {
      // set rxUserResponse to new (debounced) value
      widget.rxUserResponse.value.responseType.value = value;
      // todo: update active response in UserResponsesController
      // todo: extract this into a named command
    }, time: const Duration(seconds: 1));
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
