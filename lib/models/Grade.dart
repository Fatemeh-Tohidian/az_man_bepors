class Grade {
  final int _id;
  final String _title;
  final int _countOfLessons;
//  final String _imageURL;
  final String _description;


//  const Grade(this._id,this._title, this._imageURL , this._description);
  const Grade(this._id,this._title , this._countOfLessons, this._description);

  int get id => _id;

  String get title => _title;

  int get countOfLessons => _countOfLessons;
//  String get imageURL =>_imageURL;

  String get description => _description;

// String getBasicURl()=> "http://10.0.2.2:5000/auth/mdata/"+_gradeNo.toString();


static Grade fromMap(Map map){

  return new Grade(map['id'] , map ['title'],map['countOfLessons'],map['description']);
}
//to do
//get tests with special url using
}
