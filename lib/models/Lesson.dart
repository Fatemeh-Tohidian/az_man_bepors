class Lesson{

 final int _id;
 final  String _title;
// final String _imageURL;
 final String _description;

// const Unit(this._id , this._title , this._imageURL , this._description);
 const Lesson(this._id , this._title , this._description);


  int get id => _id;

  String get title => _title;

//  String get imageURL =>_imageURL;

  String get description => _description;

 static Lesson fromMap(Map map){

   return new Lesson(map['id'], map['title'], map['description']);

  }

}