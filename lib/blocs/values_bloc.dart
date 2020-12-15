import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:recruitment_task/consts/values.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ValuesBLoC {
  BehaviorSubject<List<String>> _userValues = BehaviorSubject<List<String>>()
    ..add([]);

  BehaviorSubject<List<String>> _userFavorites = BehaviorSubject<List<String>>()
    ..add([]);

  BehaviorSubject<int> _drawnSentenceIndex = BehaviorSubject<int>()..add(0);

  Stream<String> get sentence => Rx.combineLatest2(sentencesList,
      _drawnSentenceIndex, (sentences, index) => sentences[index]).cast();

  Stream<List<String>> get sentencesList => _userValues
      .map(
        (userValues) => defaultSentences..addAll(userValues),
      )
      .cast();

  Stream<List<String>> get userList => _userValues.cast();

  Stream<List<String>> get favoriteList => _userFavorites.cast();

  SharedPreferences prefs;

  void initState() async {
    prefs = await SharedPreferences.getInstance();
    _drawSentences();
    fetchUserList();
    fetchFavoritesList();
  }

  void _drawSentences() {
    _drawSentence();
    Timer.periodic(Duration(seconds: 5), (timer) {
      _drawSentence();
    });
  }

  void _drawSentence() {
    sentencesList.take(1).listen((sentences) {
      int nextValue = Random().nextInt(sentences.length);
      if (nextValue == _drawnSentenceIndex.value) {
        _drawSentence();
        return;
      }
      _drawnSentenceIndex.add(nextValue);
    });
  }

  void addValueToList(String newValue) {
    String userValues = prefs.getString('userValues');
    List<String> userValuesList =
        userValues == null ? [] : List<String>.from(jsonDecode(userValues));
    userValuesList.add(newValue);
    _userValues.add(userValuesList);
    prefs.setString(
      'userValues',
      jsonEncode(userValuesList),
    );
  }

  void fetchUserList() {
    String userValues = prefs.getString('userValues');
    if (userValues == null) return;
    List<String> userValuesList = List<String>.from(
      jsonDecode(userValues),
    );
    _userValues.add(userValuesList);
  }

  void addToFavoritesList(String newFavorite) {
    String userFavorites = prefs.getString('userFavorites');
    List<String> userFavoritesList = userFavorites == null
        ? []
        : List<String>.from(jsonDecode(userFavorites));
    userFavoritesList.add(newFavorite);
    _userFavorites.add(userFavoritesList);
    prefs.setString(
      'userFavorites',
      jsonEncode(userFavoritesList),
    );
  }

  void fetchFavoritesList() {
    String userFavorites = prefs.getString('userFavorites');
    if (userFavorites == null) return;
    List<String> userFavoritesList = List<String>.from(
      jsonDecode(userFavorites),
    );
    _userFavorites.add(userFavoritesList);
  }
}
