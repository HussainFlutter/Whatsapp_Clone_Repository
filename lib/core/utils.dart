

import 'package:flutter/cupertino.dart';

// Media Query height and width extension

extension MediaHeight on double {
  double mediaH (BuildContext context) {
    return MediaQuery.of(context).size.height * this;
  }
}

extension MediaWidth on double {
  double mediaW (BuildContext context) {
    return MediaQuery.of(context).size.width * this;
  }
}

// SizedBox extension

extension SizeVertical on double {
  Widget sizeH (BuildContext context) {
    return SizedBox(height: mediaH(context), );
  }
}

extension SizeHorizontal on double {
  Widget sizeW (BuildContext context) {
    return SizedBox(width: mediaW(context), );
  }
}