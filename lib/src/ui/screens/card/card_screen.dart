import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/card/card.dart' as model;
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/resources/app_dimen.dart';
import 'package:bank_cards/src/ui/resources/app_styles.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/screens/card/card_detail_widget.dart';
import 'package:bank_cards/src/ui/widgets/credit_card/credit_card_front.dart';
import 'package:bank_cards/src/ui/widgets/custom_circular_progress_indicator.dart';
import 'package:bank_cards/src/ui/widgets/menu/horizontal_menu_widget.dart';
import 'package:bank_cards/src/ui/widgets/menu/menu_item_widget.dart';
import 'package:bank_cards/src/viewmodel/base/base_viewmodel.dart';
import 'package:bank_cards/src/viewmodel/card/card_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class CardScreen extends StatefulWidget {
  @override
  _CardScreenState createState() => _CardScreenState();
}

class _CardScreenState extends State<CardScreen> {
  List<Widget> _menuItems;
  CardViewModel cardViewModel;

  @override
  void initState() {
    super.initState();

    this.cardViewModel = Provider.of<CardViewModel>(context, listen: false);

    //Load cards only when build is complete
    WidgetsBinding.instance.addPostFrameCallback((_) {
      loadCards();
    });
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    _menuItems = [
      createNewItem(
          "assets/images/ic_statement.png", S.of(context).statement, 0),
      createNewItem("assets/images/ic_payments.png", S.of(context).payments, 1),
      createNewItem("assets/images/ic_invoices.png", S.of(context).invoices, 2),
      createNewItem(
          "assets/images/ic_statement.png", S.of(context).investments, 3),
      createNewItem("assets/images/ic_services.png", S.of(context).more, 4),
    ];

    return Container(
      decoration: BoxDecoration(
        gradient: Decorations.gradientDecoration(),
      ),
      width: screenSize.width,
      height: screenSize.height,
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                top: ScreenUtil.instance.setWidth(AppDimen.defaultMargin),
              ),
              child: Text(
                S.of(context).my_cards_title.toUpperCase(),
                style: AppStyles.defaultTitleStyle(),
              ),
            ),
            Selector<CardViewModel, ViewState>(
              selector: (buildContext, model) => model.state,
              builder: (context, value, child) => value != ViewState.Busy
                  ? SizedBox(
                      height:
                          ScreenUtil.instance.setHeight(AppDimen.cardsHeight),
                      child: new Swiper(
                        itemBuilder: (BuildContext context, int index) {
                          return CreditCardFront();
                        },
                        onIndexChanged: (int index) {
                          this.cardViewModel.changeCurrentCard(
                              this.cardViewModel.cards[index]);
                        },
                        itemCount: this.cardViewModel.cards.length,
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
                          ScreenUtil.instance.setHeight(AppDimen.cardsHeight),
                      width: ScreenUtil.instance.setWidth(AppDimen.cardsWidth),
                      padding: EdgeInsets.all(
                        ScreenUtil.instance.setWidth(10),
                      ),
                      child: Center(
                        child: CustomCircularProgressIndicator(),
                      ),
                    ),
            ),
            Column(
              children: <Widget>[
                Selector<CardViewModel, model.Card>(
                  selector: (buildContext, model) => model.currentCard,
                  builder: (context, value, child) => CardDetailWidget(
                    privateCard: value,
                  ),
                ),
                //this.menu(model),
                HorizontalMenuWidget(
                  menuItems: this._menuItems,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget createNewItem(img, text, position) {
    return new GestureDetector(
      onTap: () {
        switch (position) {
          case 0:
            Navigator.pushNamed(context, Router.CARD_STATEMENT,
                arguments: this.cardViewModel.currentCard);
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
      child: MenuItemWidget(
        image: img,
        text: text,
      ),
    );
  }

  void loadCards() async {
    await this.cardViewModel.getCards();
  }
}
