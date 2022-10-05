import 'package:car_world_system/sources/ui/login/choose_interest_brand.dart';
import 'package:car_world_system/sources/ui/login/information_declaration_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class WelcomeScreenChooseBrand extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _WelcomeScreenChooseBrand();
  }
}

class _WelcomeScreenChooseBrand extends State<WelcomeScreenChooseBrand> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image(
            image: const AssetImage("assets/images/background1.jpg"),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                SizedBox(height: 30.0.h),
                Text(
                  "CWS    XIN    CHÀO ",
                  style: GoogleFonts.monoton(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 27.0.sp,
                    ),
                  ),
                ),
                Text(
                  "Trước khi đến với Car World,\n Hãy chọn các hãng xe bạn yêu thích nhé! ",
                  style: GoogleFonts.anton(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0.sp,
                    ),
                  ),
                ),
                FittedBox(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(
                        builder: (context) {
                          return ChooseInterestBrand();
                        },
                      ));
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 50),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 26, vertical: 16),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        color: const Color(0xFFFFBD73),
                      ),
                      child: Row(
                        children: <Widget>[
                          Text(
                            "TIẾP TỤC",
                            style: Theme.of(context).textTheme.button!.copyWith(
                                  color: Colors.black,
                                ),
                          ),
                          const SizedBox(width: 10),
                          const Icon(
                            Icons.arrow_forward,
                            color: Colors.black,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
