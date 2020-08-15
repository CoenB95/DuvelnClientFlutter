import 'dart:math' as math;

import 'package:duveln_flutter/card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// class CardWidget extends StatelessWidget {
//   final PlayCard card;

//   CardWidget([this.card]);
class CardWidget extends StatefulWidget {
  final PlayCard card;

  CardWidget({this.card});

  @override
  State<CardWidget> createState() => CardState();
}

class CardState extends State<CardWidget> {
  Card _oldCard;
  Card _newCard;
  bool flipped = false;

  CardState() {
    _oldCard = _playCard(null);
  }

  @override
  Widget build(BuildContext context) {
    _newCard = _playCard(widget.card);
    return TweenAnimationBuilder(
        duration: Duration(milliseconds: 500),
        tween: Tween<double>(begin: 0, end: flipped ? 180 : 0),
        curve: Curves.easeInOut,
        builder: (context, value, child) {
          var front = flipped ? _oldCard : _newCard;
          var back = flipped ? _newCard : _oldCard;
          var face = value < 90 ? front : back;
          return Transform(
              transform: Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY((value < 90 ? value : 180 + value) * math.pi / 180),
              alignment: FractionalOffset.center,
              child: face);
        });
  }

  @override
  void didUpdateWidget(CardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.card != widget.card) {
      _oldCard = _newCard;
      flipped = !flipped;
    }
  }

  Widget _playCard(PlayCard playCard) {
    String assetName = playCard == null
        ? 'assets/playing_cards/back.png'
        : 'assets/playing_cards/${playCard.rank.name.toLowerCase()}_of_${playCard.suit.name.toLowerCase()}.png';

    return Card(
      child: Image.asset(
        assetName,
      ),
      elevation: 5.0,
    );
  }
}
