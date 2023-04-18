import 'package:shared_preferences/shared_preferences.dart';

class ScoreRepository {
  SharedPreferences? pref;

  void setNewScore(int boardSize, int score) async {
    pref ??= await SharedPreferences.getInstance();
    await pref?.setInt('score$boardSize', score);
  }

  Future<int> getBestScore(int boardSize) async {
    pref ??= await SharedPreferences.getInstance();
    var score = pref?.getInt('score$boardSize');
    return score ?? 0;
  }
}
