import 'dart:io';

class profilePicture {
  static File _img;

  static void setImage(img) {
    _img = img;
  }

  static get getImg {
    return _img;
  }
}
