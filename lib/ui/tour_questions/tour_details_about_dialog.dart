import 'package:flutter/material.dart';
import 'package:what_when_where/db_chgk_info/models/tour.dart';
import 'package:what_when_where/resources/strings.dart';

class TourDetailsAboutDialog {
  final String _detailsText;
  final String _tourTitle;

  TourDetailsAboutDialog({@required Tour tour})
      : this._tourTitle = tour.title,
        this._detailsText = _buildDetailsText(tour);

  void show(BuildContext context) => showDialog<Object>(
      context: context, builder: (context) => _createDialog(context));

  Widget _createDialog(BuildContext context) => AlertDialog(
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        title: Text(
          _tourTitle,
          style: Theme.of(context)
              .textTheme
              .title
              .copyWith(color: Theme.of(context).accentColor),
        ),
        content: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
          child: Text(
            _detailsText,
            style: Theme.of(context).textTheme.body2,
          ),
        ),
        actions: [
          FlatButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text(Strings.close),
          ),
        ],
      );

  static String _buildDetailsText(Tour tour) {
    final result = StringBuffer();

    final addToResult = (String s) {
      if (result.isNotEmpty) {
        result.writeln();
      }
      result.writeln(s);
    };

    if (tour.editors != null) {
      addToResult(tour.editors);
    }

    if (tour.description != null) {
      addToResult(tour.description);
    }

    if (tour.questionsCount != null) {
      addToResult('${Strings.questions}: ${tour.questionsCount}');
    }

    if (tour.playedAt != null) {
      addToResult('${Strings.playedAt} ${tour.playedAt}');
    }

    if (tour.createdAt != null) {
      addToResult('${Strings.addedAt} ${tour.createdAt}');
    }

    return result.toString();
  }
}
