import 'package:flutter/material.dart';

import 'game_logic.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String currentPlayer = "X";
  bool isSwitched = false;
  Game game = Game();
  bool gameOver = false;
  int turn = 0;
  @override
  Widget build(BuildContext context) {
    final islandScape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Scaffold(
      body: SafeArea(
        child: !islandScape
            ?
        Column(
          children: <Widget>[
            ...firstBlock(),
            buildExpanded(context),
            ...secondBlock(),

          ],
        ) :
            Row(
              children: <Widget>[
                Expanded(
                    child:
                    Column(
                      children: <Widget>[
                        ...firstBlock(),
                        ...secondBlock(),
                      ],
                    )
                ),
                buildExpanded(context)
              ],
            )
        ,
      ),
    );
  }

  List<Widget> firstBlock()
  {
    return [
      SwitchListTile(
          inactiveTrackColor: Colors.grey,
          contentPadding:
           EdgeInsets.symmetric(horizontal: 50, vertical: MediaQuery.of(context).orientation == Orientation.landscape? 20 : 50),
          title: const Text(
            "Two Players",
            style: TextStyle(fontSize: 30),
          ),
          value: isSwitched,
          onChanged: (newVal) {
            setState(() {
              isSwitched = newVal;
            });
          }),
      Padding(
        padding: const EdgeInsets.only(bottom: 20.0),
        child: Text(
          "It's $currentPlayer Turn".toUpperCase(),
          style: const TextStyle(fontSize: 30),
        ),
      ),
      /*const SizedBox(
        height: 20,
      ),*/
    ];
  }

  List<Widget> secondBlock()
  {
    return [
      SizedBox(
        width: 250,
        height: 190,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70.0),
          child: ElevatedButton.icon(
            icon: const Icon(
              Icons.restart_alt,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                Player.playerX = [];
                Player.playerO = [];
                turn = 0;
                gameOver = false;
              });
            },
            label: const Text(
              "Restart",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      )
    ];
  }

  Expanded buildExpanded(BuildContext context) {
    return Expanded(
            child: GridView.count(
              padding:EdgeInsets.symmetric(
                  //vertical: (MediaQuery.of(context).padding.top + 10),
                  horizontal:
                  MediaQuery.of(context).orientation == Orientation.landscape
                      ? (MediaQuery.of(context).padding.horizontal + 50)
                      : (MediaQuery.of(context).padding.horizontal + 15)),
              crossAxisCount: 3,
              mainAxisSpacing: 10,
              crossAxisSpacing: 5,
              children: List.generate(
                9,
                (index) => InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: gameOver ? null : () {
                    onTap(index);
                  },
                  child: Card(
                    elevation: 10,
                    shadowColor: Theme.of(context).colorScheme.secondary,
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.6),
                    child: Center(
                      child: Text(
                        (Player.playerX.contains(index)
                            ? "X"
                            : Player.playerO.contains(index)
                                ? "O"
                                : ""),
                        style: TextStyle(
                            fontSize: 40,
                            color: Player.playerX.contains(index)
                                ? Colors.lightBlue
                                : Colors.purpleAccent),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
  }

  void onTap(int index) {
    setState(() {
      if(!Player.playerO.contains(index) && !Player.playerX.contains(index))
      {
        game.playGame(index, currentPlayer);
        updateState();
      }

      if(!isSwitched && !gameOver && turn != 9)
        {
          game.autoPlay(currentPlayer);
          updateState();
        }
    });
  }

  void updateState() {
    currentPlayer = currentPlayer == "X" ? "O" : "X";
    turn++;

    String winner = game.checkWinner();
    String result = "";

    if(winner != "")
      {
        gameOver = true;
        result = "$winner is The Winner";
        buildDialog(result);
      }
    else if(!gameOver && turn == 9)
      {
        result = "DRAW";
        buildDialog(result);
      }





  }

  void buildDialog(String? result) {
    final AlertDialog alert = AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      title: Text(
        result == "DRAW" ? "Good Luck :' " : "Congratulations ^^",
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: 90,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            Text(
              result!,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                        Colors.indigo.withOpacity(0.7)),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text(
                    "OK",
                    style: TextStyle(color: Colors.white),
                  )),
            ),
          ],
        ),
      ),
    );
    showDialog(
        context: context,
        builder: (BuildContext ctx) {
          return alert;
        },
        barrierDismissible: true,
        barrierColor: Colors.greenAccent.withOpacity(0.3));
  }
}
