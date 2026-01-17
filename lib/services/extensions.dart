import 'package:flutter/cupertino.dart';


extension EmtptyPadding on num {
  SizedBox get ph => SizedBox(
        height: toDouble(),
      );
  SizedBox get pw => SizedBox(
        width: toDouble(),
      );
}

double widthOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double heightOfScreen(BuildContext context) {
  return MediaQuery.of(context).size.height;
}

double assignHeight({
  required BuildContext context,
  required double fraction,
  double additions = 0,
  double subs = 0,
}) {
  return (heightOfScreen(context) - (subs) + (additions)) * fraction;
}

double assignWidth({
  required BuildContext context,
  required double fraction,
  double additions = 0,
  double subs = 0,
}) {
  return (widthOfScreen(context) - (subs) + (additions)) * fraction;
}

