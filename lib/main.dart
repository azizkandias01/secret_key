import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:secret_key/detail.dart';
import 'package:secret_key/screen/atbash_cipher.dart';
import 'package:secret_key/screen/autokey_cipher.dart';
import 'package:secret_key/screen/keyword_cipher.dart';
import 'package:secret_key/screen/railfence_cipher.dart';
import 'package:secret_key/screen/vigenere_cipher.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ciphers = [
      'Caesar',
      'Keyword',
      'Auto Key',
      'Rail Fence',
      'Vigenere',
      'Atbash'
    ];
    final colors = [
      Colors.greenAccent,
      Colors.amber,
      Colors.blueAccent,
      Colors.brown,
      Colors.cyan,
      Colors.indigo
    ];
    return ScreenUtilInit(
      builder: () {
        return MaterialApp(
          initialRoute: '/',
          routes: {
            ciphers[0]: (context) => const Caesar(),
            ciphers[1]: (context) => const Keyword(),
            ciphers[2]: (context) => const AutoKey(),
            ciphers[3]: (context) => const RailFence(),
            ciphers[4]: (context) => const Vigenere(),
            ciphers[5]: (context) => const Atbash(),
          },
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            body: Stack(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Container(
                      color: const Color.fromRGBO(0, 102, 79, 100),
                    ),
                    Container(
                      width: 375.w,
                      height: 506.h,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32),
                        ),
                      ),
                      child: Padding(
                        padding: EdgeInsets.only(left: 28.w, right: 28.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 28.h,
                            ),
                            Text(
                              "Hide Your Text",
                              style: GoogleFonts.poppins(
                                  fontSize: 24.sp, fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 4.h,
                            ),
                            Text(
                              "Select algorithm ",
                              style: GoogleFonts.poppins(
                                  fontSize: 14.sp, color: Colors.grey),
                            ),
                            SizedBox(
                              height: 400.h,
                              width: 375.w,
                              child: GridView.count(
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 10.h,
                                crossAxisCount: 2,
                                children: List.generate(
                                  6,
                                  (index) {
                                    return Builder(builder: (context) {
                                      return GestureDetector(
                                        onTap: () => Navigator.pushNamed(
                                          context,
                                          ciphers[index],
                                        ),
                                        child: Container(
                                          height: 119.h,
                                          width: 149.w,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional
                                                    .circular(15),
                                            color: colors[index],
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Image.asset(
                                                "assets/caesar.png",
                                                width: 100.w,
                                                height: 100.h,
                                              ),
                                              SizedBox(
                                                height: 5.h,
                                              ),
                                              Text(
                                                ciphers[index],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                Positioned(
                  left: 94.w,
                  top: 42.h,
                  child: SvgPicture.asset('assets/book_globe.svg'),
                ),
              ],
            ),
          ),
        );
      },
      designSize: const Size(375, 812),
    );
  }
}
