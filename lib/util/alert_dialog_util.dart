import 'package:flutter/material.dart';

class AlertDialogUtil {
  static void showLoadingDialog(BuildContext context, String title) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Center(
                child: CircularProgressIndicator(),
              ),
            ));
  }

  static void showErrorDialog(BuildContext context, {String title}) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text('Ops! Ocorreu um erro :C'),
              content: Center(
                child: Text(title ?? "Tente novamente mais tarde."),
              ),
              actions: [
                FlatButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text("OK"),
                )
              ],
            ));
  }

  static void showWarningDialog(
      BuildContext context, String title, Function onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.warning,
                  color: Colors.red,
                  size: 48,
                ),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(title),
              )
            ],
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            FlatButton(
              child: new Text("Sim"),
              onPressed: onPressed,
            ),
            FlatButton(
              child: new Text("Não"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  static void showDoneDialog(
      BuildContext context, String title, Function onPressed) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: Column(
            children: [
              Icon(Icons.check, color: Colors.blue, size: 48),
              Text(title)
            ],
          ),
          actions: <Widget>[
            FlatButton(
              child: new Text("Ok"),
              onPressed: onPressed,
            ),
          ],
        );
      },
    );
  }
}
