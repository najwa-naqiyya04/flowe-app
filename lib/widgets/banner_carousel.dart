import 'dart:async';

import 'package:flowee_app/models/promo_banner.dart';
import 'package:flowee_app/widgets/banner_slide.dart';
import 'package:flowee_app/widgets/carousel_dost.dart';
import 'package:flutter/material.dart';

//carausel bnner akan bergeser otomatis setiap beberapa detik untuk handling timer seperti ini kita butuh peran statfull widget untuk melakukan perubahan widget pada layar
class BannerCarousel extends StatefulWidget {
  const BannerCarousel({super.key, required this.banners});

  final List<PromoBanner> banners;

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  /**
   * pageController yg mengatur slide yg sedang tampil
   */

  late final PageController _controller = PageController();
  Timer? _timer;
  int _page = 0;

  @override
  void initState() {
    super.initState();

    //timer.periodic => akan menjalankan fungsi di dalamnya secara berulang ulang
    _timer = Timer.periodic(Duration(seconds: 4), (_) {
      if (!mounted || widget.banners.isEmpty) return;
      final next = (_page + 1) % widget.banners.length;
      _controller.animateToPage(
        next,
        duration: Duration(milliseconds: 500),
        curve: Curves.easeInCubic
      );
    });
  }

  @override
  /**
   * Timer HARUS di cancel saat widget di hancurkan (saat tidak tampil di layar, 
   * kalua lupa kita cancel timer akan terus mencoba jalan di latar belakang atau 
   * beaground walau carauselnya sudah tidak muncul di layar ini salah satu penyebab memory lay)
   */

  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
   if(widget.banners.isEmpty) return const SizedBox.shrink();

   return Column(
    children: [
      SizedBox(
        height: 168,
        child: PageView.builder(
          controller: _controller,
          itemCount: widget.banners.length,
          /**
           * dipanggil juka saat pengguna swipe manual
           * digeser manual oleh timer,supaya titik indikator di bawah selalu sinkron dengan slide yg bener bener tampil
           */

          onPageChanged: (index) => setState(() => _page = index),
          itemBuilder: (context, index) => BannerSlide(banner: widget.banners[index]),
        ),
      ),
      SizedBox(height: 10),
      CarouselDost(
        count: widget.banners.length,
        activeIndex: _page,
        activeColor: widget.banners[_page].gradientColors.first,
      )
    ],
   );
  }
}