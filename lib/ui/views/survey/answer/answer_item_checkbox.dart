import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prapare/controllers/commands/commands.dart';
import 'package:prapare/models/fhir_questionnaire/survey/export.dart';

import 'answer_item_checkbox_controller.dart';
import 'answer_title.dart';

class AnswerItemCheckbox extends StatelessWidget {
  const AnswerItemCheckbox(
      {Key key, @required this.answer, @required this.userResponse})
      : super(key: key);

  final Answer answer;
  final UserResponse userResponse;

  @override
  Widget build(BuildContext context) {
    return GetX<AnswerItemCheckboxController>(
      init: AnswerItemCheckboxController(),
      initState: (_) {},
      builder: (_) {
        _.rxUserResponse = userResponse;
        return CheckboxListTile(
            title: AnswerTitle(answer: answer),
            value: _.rxUserResponse.responseType.value,
            onChanged: (newValue) async =>
                ToggleCheckboxCommand().execute(userResponse: userResponse));
      },
    );
  }
}
