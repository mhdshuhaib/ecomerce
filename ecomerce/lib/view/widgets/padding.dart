import 'package:flutter/material.dart';

Padding setPadding(
    {double? start,
    double? top,
    double? end,
    double? bottom,
    required Widget widget}) {
  return Padding(
    padding: EdgeInsetsDirectional.fromSTEB(
        start ?? 0, top ?? 0, end ?? 0, bottom ?? 0),
    child: widget,
  );
}
