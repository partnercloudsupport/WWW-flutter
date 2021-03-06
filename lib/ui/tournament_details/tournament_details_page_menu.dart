import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/browsing/actions.dart';
import 'package:what_when_where/redux/navigation/actions.dart';
import 'package:what_when_where/redux/sharing/actions.dart';
import 'package:what_when_where/resources/strings.dart';
import 'package:what_when_where/utils/function_holder.dart';

class TournamentDetailsPageMenu {
  List<Widget> createAppBarMenuActions(BuildContext context) => <Widget>[
        IconButton(
          icon: const Icon(Icons.more_vert),
          onPressed: () => _showMenu(context),
        ),
      ];

  void _showMenu(BuildContext context) => showModalBottomSheet<Object>(
      context: context,
      builder: (context) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _createBrowseMenuItem(context),
              _createShareMenuItem(context),
              _createAboutMenuItem(context),
            ],
          ));

  Widget _createBrowseMenuItem(BuildContext context) =>
      StoreConnector<AppState, Tuple2<bool, FunctionHolder>>(
        distinct: true,
        converter: (store) => Tuple2(
            store.state.tournamentState.hasData,
            FunctionHolder(() => store.dispatch(
                BrowseTournament(store.state.tournamentState.tournament)))),
        builder: (context, data) {
          final isEnabled = data.item1;
          final execute = data.item2.function;

          return ListTile(
            leading: const Icon(Icons.open_in_browser),
            title: const Text(Strings.browse),
            enabled: isEnabled,
            onTap: () {
              Navigator.pop(context);
              execute();
            },
          );
        },
      );

  Widget _createShareMenuItem(BuildContext context) =>
      StoreConnector<AppState, Tuple2<bool, FunctionHolder>>(
        distinct: true,
        converter: (store) => Tuple2(
            store.state.tournamentState.hasData,
            FunctionHolder(() => store.dispatch(
                ShareTournament(store.state.tournamentState.tournament)))),
        builder: (context, data) {
          final isEnabled = data.item1;
          final execute = data.item2.function;

          return ListTile(
            leading: const Icon(Icons.share),
            title: const Text(Strings.share),
            enabled: isEnabled,
            onTap: () {
              Navigator.pop(context);
              execute();
            },
          );
        },
      );

  Widget _createAboutMenuItem(BuildContext context) =>
      StoreConnector<AppState, Tuple2<bool, FunctionHolder>>(
        distinct: true,
        converter: (store) => Tuple2(
            store.state.tournamentState.hasData,
            FunctionHolder(() => store.dispatch(OpenTournamentInfo(
                context: context,
                tournament: store.state.tournamentState.tournament)))),
        builder: (context, data) {
          final isEnabled = data.item1;
          final execute = data.item2.function;

          return ListTile(
            leading: const Icon(Icons.info_outline),
            title: const Text(Strings.aboutTournament),
            enabled: isEnabled,
            onTap: () {
              Navigator.pop(context);
              execute();
            },
          );
        },
      );
}
