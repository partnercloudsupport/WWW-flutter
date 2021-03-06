import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:tuple/tuple.dart';
import 'package:what_when_where/redux/app/state.dart';
import 'package:what_when_where/redux/questions/actions.dart';
import 'package:what_when_where/redux/timer/actions.dart';
import 'package:what_when_where/ui/tour_questions/question_card.dart';
import 'package:what_when_where/ui/tour_questions/timer_button.dart';
import 'package:what_when_where/ui/tour_questions/timer_text.dart';
import 'package:what_when_where/ui/tour_questions/tour_questions_page_menu.dart';
import 'package:what_when_where/utils/function_holder.dart';

class TourQuestionsPage extends StatefulWidget {
  static const String routeName = 'questions';

  @override
  _TourQuestionsPageState createState() => _TourQuestionsPageState();
}

class _TourQuestionsPageState extends State<TourQuestionsPage> {
  final _menu = TourQuestionsPageMenu();

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: TimerButton(),
        appBar: _buildAppBar(context),
        bottomNavigationBar: _buildBottomAppBar(context),
        body: _buildPages(),
      );

  Widget _buildBottomAppBar(BuildContext context) => BottomAppBar(
      color: Theme.of(context).primaryColor,
      child: IconTheme(
        data: Theme.of(context).primaryIconTheme,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            TimerText(),
            _menu.createAppBarMenuAction(context),
          ],
        ),
      ));

  Widget _buildAppBar(BuildContext context) => AppBar(
        backgroundColor: Theme.of(context).canvasColor,
        iconTheme: Theme.of(context).iconTheme,
        elevation: 0.0,
      );

  Widget _buildPages() =>
      StoreConnector<AppState, Tuple3<int, int, FunctionHolder>>(
        distinct: true,
        converter: (store) => Tuple3(
                store.state.questionsState.questions.length,
                store.state.questionsState.currentQuestionIndex,
                FunctionHolder((int index) {
              store.dispatch(ResetTimer());
              store.dispatch(SelectQuestion(index));
            })),
        builder: (context, data) {
          final count = data.item1;
          final startIndex = data.item2;
          final onPageChanged = data.item3;

          return PageView.builder(
            controller:
                PageController(initialPage: startIndex, viewportFraction: 0.85),
            itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: kToolbarHeight),
                child: QuestionCard(index: index)),
            itemCount: count,
            onPageChanged: (index) => onPageChanged.function(index),
          );
        },
        onDispose: (store) {
          store.dispatch(ResetTimer());
          store.dispatch(VoidQuestions());
        },
      );
}
