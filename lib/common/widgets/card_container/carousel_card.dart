import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wcycle_bd_store/core/config/theme/app_color.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Announcement tittle",
                textAlign: TextAlign.center,
                style: GoogleFonts.damion(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    style: GoogleFonts.spectral(
                        color: AppColor.kLightColor, fontSize: 12),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                    "Environmental pollution is a global issue for both developed and developing economies. These manmade activities influence all the components of the environment.Environmental pollution is a global issue for both developed and developing economies. These manmade activities influence all the components of the environment."),
              ),
              const Gap(2),
              TextButton(
                  onPressed: () {},
                  child: const Align(
                    alignment: Alignment.bottomLeft,
                    child: Card(
                      color: Colors.orange,
                      elevation: 5,
                      child: Padding(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          "Watch",
                          style: TextStyle(
                              color: Colors.yellowAccent, fontSize: 10),
                        ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
        Flexible(
          flex: 1,
          child: ClipRRect(
            borderRadius: const BorderRadius.horizontal(
                left: Radius.circular(5), right: Radius.circular(30)),
            child: Image.asset(
              fit: BoxFit.cover,
              "assets/map/maps.png",
              height: double.infinity,
              width: double.infinity,
            ),
          ),
        )
      ],
    );
  }
}
