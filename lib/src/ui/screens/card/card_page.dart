import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/models/card/card_dto.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/resources/custom_colors.dart' as tricardColors;
import 'package:bank_cards/src/utils/formatter.dart';
import 'package:bank_cards/src/viewmodel/base/BaseViewModel.dart';
import 'package:bank_cards/src/viewmodel/card/card_viewmodel.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/repository/card/service/card/card_response.dart';

class CardPage extends StatefulWidget {
  @override
  _CardPageState createState() => _CardPageState();
}

class _CardPageState extends State<CardPage> {
  List<Widget> _menuItems;
  model.Card _privateCard;
  CardResponse _response;

  @override
  void initState() {
    _menuItems = [
      createNewItem("assets/images/extrato_verde.png", 'Statement', 0),
      createNewItem("assets/images/pagamentos_verde.png", 'Pay Invoice', 1),
      createNewItem("assets/images/transferencias_verde.png", 'Invoices', 2),
      createNewItem("assets/images/investimentos_verde.png", 'Investments', 3),
      createNewItem("assets/images/servicos_verde.png", 'More', 4),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseWidget<CardViewModel>(
      model: CardViewModel(repository: Provider.of(context)),
      onModelReady: (model) async {
        _response = await model.getCards();
        if (_response != null) {
          _privateCard = _response.cards[0];
        }
      },
      builder: (mainContext, model, child) => new Container(
        margin: EdgeInsets.only(top: 15.0),
        color: Colors.white,
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              model.state != ViewState.Busy
                  ? SizedBox(
                      height: 230.0,
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return new Image.network(
                            _response.cards[index].cardImage,
                            fit: BoxFit.fill,
                          );
                        },
                        //index: _currentIndex,
                        onIndexChanged: (int index) {
                          setState(() {
                            _privateCard = _response.cards[index];
                          });
                        },
                        itemCount: _response.cards.length,
                        outer: true,
                        fade: 0.8,
                        loop: false,
                        viewportFraction: 0.7,
                        scale: 0.8,
                        pagination: new SwiperPagination(),
                        control: new SwiperControl(),
                      ),
                    )
                  : Container(
                      height: 80.0,
                      width: 80.0,
                      padding: EdgeInsets.all(10),
                      child: CustomCircularProgressIndicator(),
                    ),
              Column(
                children: <Widget>[
                  this.cardDetails(model),
                  this.menu(model),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget cardDetails(CardViewModel model) {
    return Column(
      children: <Widget>[
        Container(
          child: Card(
            child: Row(
              children: <Widget>[
                Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Due date"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Better day"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          model.state != ViewState.Busy && _privateCard != null
                              ? _privateCard.dueDate.toString()
                              : " - "),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          model.state != ViewState.Busy && _privateCard != null
                              ? _privateCard.bestBuyDate.toString()
                              : " - "),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Used"),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Available"),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          model.state != ViewState.Busy && _privateCard != null
                              ? Formatter.moneyFormatter(_privateCard.limitUsed)
                              : " - "),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                          model.state != ViewState.Busy && _privateCard != null
                              ? Formatter.moneyFormatter(
                                  _privateCard.limitAvailable)
                              : " - "),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget menu(model) {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 10.0),
      height: 300.0,
      child: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        crossAxisCount: 3,
        children: this._menuItems,
      ),
    );
  }

  Widget createNewItem(img, text, position) {
    return new GestureDetector(
      onTap: () {
        // switch (position) {
        //   case 0:
        //     Navigator.pushNamed(context, Router.CARD_STATEMENT,
        //         arguments: _privateCard);
        //     break;
        //   case 1:
        //     var cardDto = CardDto();
        //     cardDto.privateCard = _privateCard;
        //     cardDto.extraInfo = "2019-08-01"; //TODO
        //     Navigator.pushNamed(context, Router.CARD_CLOSED_INVOICE,
        //         arguments: cardDto);
        //     break;
        //   case 2:
        //     Navigator.pushNamed(context, Router.CARD_MONTHLY_CLOSED_INVOICE,
        //         arguments: _privateCard);
        //     break;
        // }
      },
      child: Container(
        height: 90,
        width: 112,
        decoration: new BoxDecoration(
          border: new Border.all(color: tricardColors.green),
          borderRadius: new BorderRadius.only(
            bottomLeft: const Radius.circular(15.0),
            bottomRight: const Radius.circular(15.0),
            topRight: const Radius.circular(15.0),
            topLeft: const Radius.circular(15.0),
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(img, width: 48),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 12,
                  color: tricardColors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
