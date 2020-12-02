import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prapare/controllers/controllers.dart';
import 'package:prapare/models/fhir_questionnaire/survey/export.dart';
import 'package:prapare/ui/views/survey/answer/answer_items.dart';

import 'question_item.dart';

class QuestionItemBoolean extends StatefulWidget {
  const QuestionItemBoolean({Key key, this.group, this.question})
      : super(key: key);

  final ItemGroup group;
  final Question question;

  @override
  _QuestionItemBooleanState createState() => _QuestionItemBooleanState();
}

class _QuestionItemBooleanState extends State<QuestionItemBoolean>
    implements QuestionItem {
  final UserResponsesController controller = Get.find();
  final RxString activeCode = ''.obs;

  @override
  ItemGroup get group => widget.group;
  @override
  Question get question => widget.question;

  @override
  Widget buildQuestion(BuildContext context) {
    final List<Answer> answerList = widget.question.answers.toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ...answerList.map(
          (answer) => AnswerItems(
            group: widget.group,
            question: widget.question,
            answer: answer,
            activeCode: activeCode,
          ),
        ),
        ...QuestionItem.buildSubQuestions(group, question),
      ],
    );
  }

  @override
  Widget build(BuildContext context) => buildQuestion(context);

  @override
  void initState() {
    final Rx<UserResponse> activeResponse =
        controller.findActiveResponse(widget.question.linkId);
    // returns most recent value, otherwise the default '' remains
    activeCode.value =
        controller.getActiveRadioButtonValue(activeResponse) ?? '';
    super.initState();
  }
}