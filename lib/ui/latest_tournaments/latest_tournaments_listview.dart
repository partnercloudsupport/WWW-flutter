import 'dart:async';

import 'package:flutter/material.dart';
import 'package:what_when_where/resources/dimensions.dart';
import 'package:what_when_where/ui/common/progress_indicator.dart';
import 'package:what_when_where/ui/latest_tournaments/latest_tournaments_bloc.dart';
import 'package:what_when_where/ui/tournament_list_tile.dart';

class LatestTournamentsListView extends StatefulWidget {
  final LatestTournamentsBloc _bloc;

  LatestTournamentsListView({Key key, @required LatestTournamentsBloc bloc})
      : this._bloc = bloc,
        super(key: key);

  @override
  _LatestTournamentsListViewState createState() =>
      _LatestTournamentsListViewState(_bloc);
}

class _LatestTournamentsListViewState extends State<LatestTournamentsListView> {
  final _scrollController = ScrollController();
  final _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  final LatestTournamentsBloc _bloc;

  _LatestTournamentsListViewState(this._bloc);

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    var state = _bloc.state;

    return RefreshIndicator(
        key: _refreshIndicatorKey,
        onRefresh: _refresh,
        child: ListView.separated(
            padding: Dimensions.defaultPadding,
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) =>
                state.isLoadingMore && index == state.data.length
                    ? WWWProgressIndicator()
                    : TournamentListTile(tournament: state.data[index]),
            separatorBuilder: (BuildContext context, int index) => Divider(),
            itemCount: state.isLoadingMore
                ? state.data.length + 1
                : state.data.length));
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() => _loadMoreIfRequested();

  void _loadMoreIfRequested() {
    if (_scrollController.position.extentAfter < 500) {
      _loadMore();
    }
  }

  void _loadMore() async {
    await _bloc.loadMore();
  }

  Future _refresh() async {
    await _bloc.refresh();

    _loadMoreIfRequested();
  }
}
