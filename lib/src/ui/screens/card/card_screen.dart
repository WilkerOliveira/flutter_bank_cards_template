import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/dimens.dart';
import 'package:bank_cards/src/ui/resources/styles.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/widgets/common/common_widgets.dart';
import 'package:bank_cards/src/ui/widgets/credit_card/credit_card_front.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/utils/formatter.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/card/card_viewmodel.dart';
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
      createNewItem("assets/images/ic_statement.png", 'Statement', 0),
      createNewItem("assets/images/ic_payments.png", 'Pay Invoice', 1),
      createNewItem("assets/images/ic_invoices.png", 'Invoices', 2),
      createNewItem("assets/images/ic_statement.png", 'Investments', 3),
      createNewItem("assets/images/ic_services.png", 'More', 4),
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
        decoration: BoxDecoration(
          gradient: Decorations.gradientDecoration(),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              model.state != ViewState.Busy
                  ? SizedBox(
                      height: Dimens.CARDS_HEIGHT,
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return CreditCardFront();
                        },
                        onIndexChanged: (int index) {
                          setState(() {
                            _privateCard = _response.cards[index];
                          });
                        },
                        itemCount: _response.cards.length,
                        outer: true,
                        fade: 0.4,
                        loop: false,
                        viewportFraction: 0.9,
                        scale: 1.0,
                        control: new SwiperControl(),
                      ),
                    )
                  : Container(
                      height: Dimens.CARDS_HEIGHT,
                      width: 80.0,
                      padding: EdgeInsets.all(10),
                      child: Center(
                        child: CustomCircularProgressIndicator(),
                      ),
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
    return Container(
      margin: EdgeInsets.only(
          left: Dimens.MARGIN_CARD_DETAIL, right: Dimens.MARGIN_CARD_DETAIL),
      child: Card(
        color: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.PADDING_CARD_DETAIL),
                    child: Text(
                      S.of(context).due_date,
                      style: titleDetailStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.PADDING_CARD_DETAIL),
                  child: Text(
                    model.state != ViewState.Busy && _privateCard != null
                        ? _privateCard.dueDate.toString()
                        : " - ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.PADDING_CARD_DETAIL),
                    child: Text(
                      S.of(context).limit,
                      style: titleDetailStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.PADDING_CARD_DETAIL),
                  child: Text(
                    model.state != ViewState.Busy && _privateCard != null
                        ? Formatter.moneyFormatter(_privateCard.limit)
                        : " - ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: getAmountColor(
                          _privateCard == null ? 0 : _privateCard.limit),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  width: 100,
                  child: Padding(
                    padding: EdgeInsets.all(Dimens.PADDING_CARD_DETAIL),
                    child: Text(
                      S.of(context).available,
                      style: titleDetailStyle(),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.PADDING_CARD_DETAIL),
                  child: Text(
                    model.state != ViewState.Busy && _privateCard != null
                        ? Formatter.moneyFormatter(_privateCard.limitAvailable)
                        : " - ",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: getAmountColor(_privateCard == null
                          ? 0
                          : _privateCard.limitAvailable),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color getAmountColor(amount) {
    return amount <= 0 ? Colors.red : Colors.green;
  }

  Widget menu(model) {
    return Container(
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
        switch (position) {
          case 0:
            Navigator.pushNamed(context, Router.CARD_STATEMENT,
                arguments: _privateCard);
            break;
//           case 1:
//             var cardDto = CardDto();
//             cardDto.privateCard = _privateCard;
//             cardDto.extraInfo = "2019-08-01"; //TODO
//             Navigator.pushNamed(context, Router.CARD_CLOSED_INVOICE,
//                 arguments: cardDto);
//             break;
//           case 2:
//             Navigator.pushNamed(context, Router.CARD_MONTHLY_CLOSED_INVOICE,
//                 arguments: _privateCard);
//             break;
        }
      },
      child: CommonWidgets.menuItem(img, text),
    );
  }
}
