import 'package:flube/src/helpers/colors.dart';
import 'package:flube/src/helpers/fonts.dart';
import 'package:flube/src/helpers/responsive.dart';
import 'package:flutter/material.dart';

class ContentNotice extends StatelessWidget {
  const ContentNotice({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      // height: 250,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: shadowColor),
        color: Colors.white30,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Notice ⚠',
            style: nStyle.copyWith(
                fontSize: SizeConfig.textSize(context, 4.5),
                fontWeight: FontWeight.w400),
          ),
          const SizedBox(height: 20,),
          Text(
            "Futures are contracts to buy or sell a certain asset at a specified price on a future date (That's why they're called futures!). Forex futures were created by the Chicago Mercantile Exchange (CME) way back in 1972, when bell bottoms and platform boots were still in style. Since futures contracts are standardized and traded through a centralized exchange, the market is very transparent and well-regulated. This means that price and transaction information are readily available",
            style: nStyle.copyWith(
                fontSize: SizeConfig.textSize(context, 4),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
