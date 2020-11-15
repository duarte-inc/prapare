import 'package:get/get.dart';
import 'package:prapare/_internal/constants/prapare_survey.dart';
import 'package:prapare/controllers/controllers.dart';
import 'package:prapare/models/fhir_questionnaire/fhir_questionnaire.dart';
import 'package:prapare/models/fhir_questionnaire/survey/export.dart';
import 'package:prapare/models/fhir_questionnaire/questionnaire_model.dart';
import 'package:prapare/models/fhir_questionnaire/survey/response_type.dart';
import 'package:prapare/ui/views/survey/survey_controller.dart';

class QuestionnaireController extends GetxController {
  /// A semi-temporary data model, which will be transitioned to harness [prapareSurvey]
  /// For now, the data points have been created manually, and the codes don't quite correlate yet

  final QuestionnaireModel _model = QuestionnaireModel();

  final UserResponsesController _responsesController = Get.find();
  List<Question> _allQuestions;

  //todo: implement error handling / orElse
  Survey getSurveyFromCode(String code) => _model.data.surveys
      .firstWhere((e) => e.code == code, orElse: () => Survey());

  //todo: implement error handling / orElse
  Survey getSurveyFromIndex(int sIndex) => _model.data.surveys[sIndex];

  //todo: implement error handling / orElse
  int getSurveyIndexFromSurvey(Survey survey) =>
      _model.data.surveys.indexWhere((e) => e == survey);

  FhirQuestionnaire getQuestionnaire() => _model.data;

  int getTotalIndexFromQuestion(Question question) =>
      _allQuestions.indexOf(question);

  void _mapAllQuestions() {
    _allQuestions =
        _model.data.surveys.map((e) => e.questions).expand((x) => x).toList();
  }

  void _mapAllUserResponses() {
    _model.data.surveys.forEach(
      (s) => s.questions.forEach(
        (q) => q.answers.forEach(
          (ans) => _responsesController.rxResponses.add(
            UserResponse(
                    surveyCode: s.code,
                    questionCode: q.code,
                    answerCode: ans.code,
                    responseType: ResponseBoolean(false))
                .obs,
          ),
        ),
      ),
    );
  }

  void _mapAllActiveResponses() {
    /// defaults to blank answer on first load
    /// afterwards, the new UserResponse will be updated to reflect the selected item
    /// then ResponseBoolean will be selected to true for that item
    /// todo: ignore question types that aren't radio-buttons
    _model.data.surveys.forEach(
      (s) => s.questions.forEach(
        (q) => _responsesController.rxMappedActiveResponses.add(
          q.code,
          UserResponse(
            surveyCode: s.code,
            questionCode: q.code,
            answerCode: '',
            responseType: ResponseBoolean(false),
          ).obs,
        ),
      ),
    );
  }

  @override
  void onInit() {
    _model.loadAndCreateSurvey();
    _mapAllQuestions();
    _mapAllUserResponses();
    _mapAllActiveResponses();
    super.onInit();
  }
}
