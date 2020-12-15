import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:recruitment_task/blocs/values_bloc.dart';
import 'package:recruitment_task/consts/values.dart';
import 'package:recruitment_task/pages/favorites_page.dart';
import 'package:recruitment_task/pages/user_values_page.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ValuesBLoC _valuesBLoC = ValuesBLoC();
  @override
  void initState() {
    super.initState();
    _valuesBLoC.initState();
  }

  Widget _buttonIconWithText(
      BuildContext context, IconData icon, String label, Function onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 54,
        width: 54,
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Icon(
            icon,
          ),
          Text(
            label,
            style: Theme.of(context).textTheme.headline3,
          ),
        ]),
      ),
    );
  }

  Future _asyncInputDialog(BuildContext context) async {
    String yourValue = '';
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(
              'Enter your value ',
            ),
            content: Row(
              children: [
                Expanded(
                  child: TextField(
                    autofocus: true,
                    decoration: InputDecoration(
                      labelText: 'Your Value',
                    ),
                    onChanged: (value) {
                      yourValue = value;
                    },
                  ),
                )
              ],
            ),
            actions: [
              FlatButton(
                child: Text('Add'),
                onPressed: () {
                  _valuesBLoC.addValueToList(yourValue);
                  Navigator.of(context).pop(yourValue);
                },
              ),
            ],
          );
        });
  }

  Widget _addButton(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          child: Container(
            height: bigCircleSize,
            width: bigCircleSize,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          left: (bigCircleSize - smallCircleSize) / 2,
          bottom: (bigCircleSize - smallCircleSize) / 2,
          height: smallCircleSize,
          width: smallCircleSize,
          child: RawMaterialButton(
            onPressed: () {
              _asyncInputDialog(context);
            },
            elevation: 2.0,
            fillColor: Colors.white,
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            shape: CircleBorder(),
          ),
        )
      ],
    );
  }

  Widget _mainText(String text) {
    return AutoSizeText(
      text,
      textAlign: TextAlign.center,
      style: Theme.of(context).textTheme.headline1,
      maxLines: 4,
      key: ValueKey<String>(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
              'Netguru\'s Core Values',
              style: Theme.of(context).textTheme.headline2,
            ),
            actions: <Widget>[
              StreamBuilder(
                  stream: _valuesBLoC.sentence,
                  builder:
                      (BuildContext context, AsyncSnapshot sentenceSnapshot) {
                    return IconButton(
                        icon: Icon(
                          Icons.favorite,
                        ),
                        onPressed: () {
                          _valuesBLoC.addToFavoritesList(sentenceSnapshot.data);
                        });
                  }),
            ]),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StreamBuilder(
                stream: _valuesBLoC.favoriteList,
                builder:
                    (BuildContext context, AsyncSnapshot sentenceSnapshot) {
                  return Container();
                }),
            Padding(
              padding: EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.center,
                child: StreamBuilder(
                  stream: _valuesBLoC.sentence,
                  builder: (
                    BuildContext context,
                    AsyncSnapshot sentenceSnapshot,
                  ) {
                    return AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      transitionBuilder:
                          (Widget child, Animation<double> animation) {
                        return ScaleTransition(child: child, scale: animation);
                      },
                      child: _mainText(sentenceSnapshot.data ?? ''),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: Colors.transparent,
          elevation: 0,
          child: Stack(
            overflow: Overflow.visible,
            children: [
              Positioned(
                child: Container(
                  height: 60,
                  color: Theme.of(context).primaryColor,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buttonIconWithText(
                            context, Icons.format_quote, 'Values', () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    UserValuesPage(valuesBLoC: _valuesBLoC)),
                          );
                        }),
                        _buttonIconWithText(context, Icons.favorite, 'Favorite',
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    FavoritesPage(valuesBLoC: _valuesBLoC)),
                          );
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 30,
                left: MediaQuery.of(context).size.width / 2 - bigCircleSize / 2,
                child: _addButton(context),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
