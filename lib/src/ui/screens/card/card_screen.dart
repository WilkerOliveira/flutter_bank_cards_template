import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/screens/base/base_screen.dart';
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
    BaseScreen.initScreenUtil(context: context);

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
              Padding(
                padding: EdgeInsets.only(
                  top: BaseScreen.screenUtil.setWidth(AppDimen.defaultMargin),
                ),
                child: Text(
                  S.of(context).my_cards_title.toUpperCase(),
                  style: AppStyles.defaultTitleStyle(BaseScreen.screenUtil),
                ),
              ),
              model.state != ViewState.Busy
                  ? SizedBox(
                      height:
                          BaseScreen.screenUtil.setHeight(AppDimen.cardsHeight),
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
                      height:
                          BaseScreen.screenUtil.setHeight(AppDimen.cardsHeight),
                      width:
                          BaseScreen.screenUtil.setWidth(AppDimen.cardsWidth),
                      padding: EdgeInsets.all(
                        BaseScreen.screenUtil.setWidth(10),
                      ),
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
        left: BaseScreen.screenUtil.setWidth(AppDimen.marginCardDetail),
        right: BaseScreen.screenUtil.setWidth(AppDimen.marginCardDetail),
      ),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.all(
          BaseScreen.screenUtil.setWidth(AppDimen.defaultMargin),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width:
                      BaseScreen.screenUtil.setWidth(AppDimen.cardDetailWidth),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                    child: Text(
                      S.of(context).due_date,
                      style: AppStyles.titleDetailStyle(BaseScreen.screenUtil),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                  child: Text(
                    model.state != ViewState.Busy && _privateCard != null
                        ? _privateCard.dueDate.toString()
                        : " - ",
                    style: AppStyles.valueDetailStyle(
                        BaseScreen.screenUtil, Colors.white),
                  ),
                ),
              ],
            ),
            Container(
              height: BaseScreen.screenUtil.setHeight(1),
              color: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width:
                      BaseScreen.screenUtil.setWidth(AppDimen.cardDetailWidth),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                    child: Text(
                      S.of(context).limit,
                      style: AppStyles.titleDetailStyle(BaseScreen.screenUtil),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                  child: Text(
                    model.state != ViewState.Busy && _privateCard != null
                        ? Formatter.moneyFormatter(_privateCard.limit)
                        : " - ",
                    style: AppStyles.valueDetailStyle(
                      BaseScreen.screenUtil,
                      getAmountColor(
                          _privateCard == null ? 0 : _privateCard.limit),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              height: BaseScreen.screenUtil.setHeight(1),
              color: Colors.green,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(
                  width:
                      BaseScreen.screenUtil.setWidth(AppDimen.cardDetailWidth),
                  child: Padding(
                    padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                    child: Text(
                      S.of(context).available,
                      style: AppStyles.titleDetailStyle(BaseScreen.screenUtil),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(AppDimen.paddingCardDetail),
                  child: Text(
                    model.state != ViewState.Busy && _privateCard != null
                        ? Formatter.moneyFormatter(_privateCard.limitAvailable)
                        : " - ",
                    style: AppStyles.valueDetailStyle(
                      BaseScreen.screenUtil,
                      getAmountColor(_privateCard == null
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
      height: BaseScreen.screenUtil.setHeight(AppDimen.menuCardHeight),
      child: GridView.count(
        primary: false,
        padding: EdgeInsets.all(
          BaseScreen.screenUtil.setWidth(20.0),
        ),
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
