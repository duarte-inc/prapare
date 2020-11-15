import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prapare/controllers/commands/commands.dart';
import 'package:prapare/models/fhir_questionnaire/survey/export.dart';

class AnswerItemDecimal extends StatefulWidget {
  const AnswerItemDecimal({
    Key key,
    @required this.answer,
    @required this.rxUserResponse,
    bool isInteger,
  })  : _isInteger = isInteger ?? false,
        assert(answer != null),
        assert(rxUserResponse != null),
        super(key: key);

  final Answer answer;
  final Rx<UserResponse> rxUserResponse;
  final bool _isInteger;

  @override
  _AnswerItemDecimalState createState() => _AnswerItemDecimalState();
}

class _AnswerItemDecimalState extends State<AnswerItemDecimal> {
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
        keyboardType:
            TextInputType.numberWithOptions(decimal: !widget._isInteger),
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: 'answer: ${widget._isInteger ? "integer" : "decimal"}',
        ),
      ),
    );
  }

  @override
  void initState() {
    _textEditingController = TextEditingController(
        text: widget.rxUserResponse.value.responseType.value);
    DebounceAndSaveResponseCommand()
        .execute(rxString: _obj, response: widget.rxUserResponse);
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}