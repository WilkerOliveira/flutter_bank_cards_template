import 'package:flutter/material.dart';
import 'package:bank_cards/src/ui/widgets/common/account_header.dart';
import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/resources/dimens.dart';
import 'package:bank_cards/src/resources/images.dart';
import 'package:bank_cards/src/resources/styles.dart';
import 'package:bank_cards/src/utils/formatter.dart';
import 'package:bank_cards/src/resources/custom_colors.dart' as customColors;

class BankPage extends StatefulWidget {
  @override
  _BankPageState createState() => _BankPageState();
}

class _BankPageState extends State<BankPage> with TickerProviderStateMixin {
  List<Widget> _menuItems;

  @override
  void initState() {
    _menuItems = [
      createNewItem("assets/images/extrato_verde.png", 'Statements', 0),
      createNewItem("assets/images/pagamentos_verde.png", 'Payments', 1),
      createNewItem(
          "assets/images/transferencias_verde.png", 'Bank Transfer', 2),
      createNewItem("assets/images/investimentos_verde.png", 'Investments', 3),
      createNewItem("assets/images/investimentos_verde.png", 'Loan', 4),
      createNewItem("assets/images/servicos_verde.png", 'More', 5),
    ];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          AccountHeader(),
          this.balance(context),
          SingleChildScrollView(child: this.menu()),
          //this.lastTransactions(),
        ],
      ),
    );
  }

  Widget balance(mainContext) {
    return Container(
      padding: EdgeInsets.only(top: Dimens.BALANCE_MARGIN_TOP),
      decoration: new BoxDecoration(
        image: new DecorationImage(
          image: new AssetImage(Images.CURVE_BACKGROUND),
          fit: BoxFit.fill,
        ),
      ),
      height: Dimens.BALANCE_BODY_HEIGHT,
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          Dimens.BALANCE_BODY_LEFT_PADDING,
          Dimens.BALANCE_BODY_TOP_PADDING,
          Dimens.BALANCE_BODY_RIGHT_PADDING,
          Dimens.BALANCE_BODY_BOTTOM_PADDING,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              S.of(context).current_balance,
              textAlign: TextAlign.start,
              style: balanceTitleStyle(),
            ),
            SizedBox(width: Dimens.BALANCE_SIZED_BOX),
            Padding(
              padding: EdgeInsets.only(top: Dimens.BALANCE_AMOUNT_TOP_PADDING),
              child: Text(
                Formatter.moneyFormatter(300),
                textAlign: TextAlign.start,
                style: balanceAmountStyle(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget menu() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
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
      onTap: () {},
      child: Container(
        height: 90,
        width: 112,
        decoration: new BoxDecoration(
          border: new Border.all(color: customColors.green),
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
                  color: customColors.blue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  var _menuItemsPopup;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.easeOut);

    controller.addListener(() {
      setState(() {});
    });

    controller.forward();

    _menuItemsPopup = [
      createNewItem2("assets/images/extrato_verde.png", 'Extratos', 0),
      createNewItem2("assets/images/pagamentos_verde.png", 'Pagamentos', 1),
      createNewItem2(
          "assets/images/transferencias_verde.png", 'Transferências', 2),
      createNewItem2(
          "assets/images/investimentos_verde.png", 'Investimentos', 3),
      createNewItem2(
          "assets/images/investimentos_verde.png", 'Investimentos', 4),
      createNewItem2("assets/images/servicos_verde.png", 'Opções', 5),
    ];
  }

  Widget menu() {
    return Container(
      //margin: EdgeInsets.symmetric(vertical: 20.0),
      height: 250.0,
      child: GridView.count(
        primary: false,
        //padding: const EdgeInsets.all(20.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        crossAxisCount: 3,
        children: this._menuItemsPopup,
      ),
    );
  }

  Widget createNewItem2(img, text, position) {
    return Container(
      height: 90,
      width: 112,
      decoration: new BoxDecoration(
        border: new Border.all(color: customColors.green),
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
                color: customColors.blue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            //margin: EdgeInsets.all(15.0),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: menu(),
            ),
          ),
        ),
      ),
    );
  }
}