import 'package:flutter/material.dart';
import 'package:zing_wait_table/waiting_api.dart';
import 'package:zing_wait_table/src/models/waiting_state.dart';

class WaitTableScreen extends StatefulWidget {
  final String title;

  WaitTableScreen({Key key, this.title}) : super(key: key);

  @override
  WaitTableScreenState createState() {
    return WaitTableScreenState();
  }
}

class WaitTableScreenState extends State<WaitTableScreen> {
  WaitingBloc bloc;

  @override
  void initState() {
    super.initState();

    bloc = WaitingBloc(widget.api);
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<WaitingState>(
        stream: bloc.state,
        initialData: WaitingNoTerm(),
        builder: (BuildContext context, AsyncSnapshot<WaitingState> snapshot) {
          final state = snapshot.data;
          return Scaffold(
              body: Stack(
                children: <Widget>[
                  Expanded(
                    child: Stack(
                      children: <Widget>[

                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          child: _waitBuildChild(state),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      child: _qrCodBuildChild(state),
                    ),
                  ),
                ],
              ),
          );
        },
    );
  }

  Widget _waitBuildChild(WaitingState state) {
    if (state is WaitingNoTerm) {
      return SearchIntro();
    } else if (state is WatingEmpty) {
      return EmptyWidget();
    } else if (state is SearchLoading) {
      return LoadingWidget();
    } else if (state is SearchError) {
      return SearchErrorWidget();
    } else if (state is WatingChangeTeam) {
      return WaitingTeamWidget(items: state.result.items);
    }

    throw Exception('${state.runtimeType} is not supported');
  }

  Widget _qrCodBuildChild(WaitingState state) {
    if (state is WaitingChangeQRCode) {
      return QrCode();
    }
  }
}