import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:what_when_where/db_chgk_info/models/tournament.dart';
import 'package:what_when_where/ui/latest_tournaments/latest_tournament_tile.dart';

class LatestTournamentsGrid extends StatelessWidget {
  final List<Tournament> tournaments;

  const LatestTournamentsGrid({Key key, @required this.tournaments})
      : super(key: key);

  @override
  Widget build(BuildContext context) => SliverStaggeredGrid.countBuilder(
      crossAxisCount: 2,
      mainAxisSpacing: 4.0,
      crossAxisSpacing: 4.0,
      itemBuilder: (c, i) => LatestTournamentTile(tournament: tournaments[i]),
      itemCount: tournaments.length,
      staggeredTileBuilder: (index) => const StaggeredTile.fit(1));
}
