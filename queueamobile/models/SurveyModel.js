
export default class SurveyModel {
    constructor(questionText, id, answerChoices, numResponses) {
        this.questionText = questionText;
        this.id = id;
        this.answerChoices = answerChoices;
        this.numResponses = numResponses;
    }
}
