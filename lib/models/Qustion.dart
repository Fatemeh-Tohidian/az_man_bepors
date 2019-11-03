class Question{

  final int _id;
  final int _lessonId;
  final String _questionText;
  final String _definition;
//  final String _soundURL;
//  final String imageURL;

//  const Question (this._id, this._lessonId, this._questionText, this._definition, this._soundURL, this.imageURL);
  const Question (this._id, this._lessonId, this._questionText, this._definition);

  int get id => _id;

  int get lessonId => _lessonId;

  String get questionText => _questionText;

  String get definition => _definition;

//  String get soundURL => _soundURL;
static Question fromMap(Map map){
  return new Question(map['id'], map['lesson_id'], map['question_text'], map['definition']);
}

}