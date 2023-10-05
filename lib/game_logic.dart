import 'dart:math';

import 'package:x_o/extensions.dart';

class Player {
  static List<int> playerX = [];
  static List<int> playerO = [];
}

var win = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [2, 4, 6],
  [0, 4, 8]
];

class Game {
  playGame(int index, String currentPlayer) {
    if (!Player.playerO.contains(index) && currentPlayer == "X") {
      Player.playerX.add(index);
    }
    if (!Player.playerX.contains(index) && currentPlayer == "O") {
      Player.playerO.add(index);
    }
  }

  checkWinner() {
    String winner = "";

    for (int i = 0; i < 8; i++) {
      if (Player.playerX.containsAll(win[i])) {
        winner = "X";
        break;
      } else if (Player.playerO.containsAll(win[i])) {
        winner = "O";
        break;
      } else {
        winner = "";
      }
    }
    return winner;
  }

  Future<void> autoPlay(currentPlayer) async {
    int? index = 0;
    List<int> emptyCells = [];

    for (int i = 0; i < 9; i++) {
      if ((!Player.playerX.contains(i)) && (!Player.playerO.contains(i))) {
        emptyCells.add(i);
      }
    }


    for(int i = 0; i < 8; i++)
      {
        if(emptyCells.contains(Player.playerX.num(win[i])[0]) )
        {
         index = Player.playerX.num(win[i])[0];
         print(Player.playerX.num(win[i])[0]);
         break;
        }

        else if(emptyCells.contains(Player.playerO.num(win[i])[0]) )
        {
         index = Player.playerO.num(win[i])[0];
         print(Player.playerO.num(win[i])[0]);
         break;
        }
        else
          {
            Random random = Random();
            int randomIndex = random.nextInt(emptyCells.length);

            index = emptyCells[randomIndex];

            print("random");
          }
      }



    playGame(index!, currentPlayer);
  }
}
