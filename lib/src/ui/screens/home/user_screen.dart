import 'package:bank_cards/generated/i18n.dart';
import 'package:bank_cards/src/models/user.dart';
import 'package:bank_cards/src/router.dart';
import 'package:bank_cards/src/ui/resources/decorations.dart';
import 'package:bank_cards/src/ui/screens/base/base_screen.dart';
import 'package:bank_cards/src/ui/screens/base/base_widget.dart';
import 'package:bank_cards/src/ui/widgets/common/buttons.dart';
import 'package:bank_cards/src/viewmodel/user_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class UserPage extends StatefulWidget {
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  @override
  Widget build(BuildContext context) {
    return BaseWidget<UserViewModel>(
      model: UserViewModel(loginRepository: Provider.of(context)),
      onModelReady: (model) async {},
      builder: (mainContext, model, child) => Container(
        decoration: BoxDecoration(
          gradient: Decorations.gradientDecoration(),
        ),
        child: Column(
          children: <Widget>[
            Card(
              color: Colors.transparent,
              child: Container(
                color: Colors.transparent,
                padding: EdgeInsets.all(10.0),
                height: 100.0,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'User Name: ' + Provider.of<User>(context).email,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Buttons.defaultButton(
                context,
                model,
                S.of(context).logout,
                (context, model) async {
                  await model.logout();
                  Navigator.pushNamed(context, Router.SIGN_IN, arguments: null);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
