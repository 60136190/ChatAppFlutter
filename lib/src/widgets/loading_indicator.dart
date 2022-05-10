import 'package:flutter/material.dart';
import 'package:task1/src/blocs/bloc.dart';
import 'package:task1/src/themes/themes.dart';

class CircularIndicator extends StatelessWidget {
  final Color color;

  CircularIndicator({this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color ?? MyTheme.accent),
      ),
    );
  }
}

class FullScreenLoadingIndicator extends StatelessWidget {
  final Bloc<bool> isLoadingBloc;
  final Color backgroundColor, spinnerColor;

  const FullScreenLoadingIndicator(this.isLoadingBloc, {
    Key key,
    this.backgroundColor = Colors.white60,
    this.spinnerColor = Colors.black
  }): super(key: key);



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: isLoadingBloc.value,
        stream: isLoadingBloc.stream,
        builder: (context, snapshot) => snapshot.data
            ? Container(
            color: backgroundColor,
            child: Center(
                child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(spinnerColor)
                )
            )
        )
            : Container()
    );
  }
}