import 'package:flutter/cupertino.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../utils/constants.dart';

Widget loading() {
  return SpinKitFadingCircle(
    color: kprimaryColor,
    size: 50.0,
  );
}
