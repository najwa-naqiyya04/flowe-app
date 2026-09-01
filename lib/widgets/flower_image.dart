import 'package:flutter/material.dart';
/**
 * manampilkan gambar dari URl internet
 * 1. sedang dimuat: menampilkan indiaktor loading
 * gagal di muat: menampil kan icon pengganti
 */
class FlowerNetworkImage extends StatelessWidget {
  const FlowerNetworkImage({
    super.key, required this.imageUrl, required this.fallbackIcon, required this.fallbackColor, required this.fit
  });

  final String imageUrl;
  final IconData fallbackIcon;
  final Color fallbackColor;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return Image.network(
      imageUrl,
      fit: fit,
      width: double.infinity,
      height: double.infinity,
      //loading indikator yg akan menjalankan terus menerus oleh fultter selama gambarnya selama masih proses download insternet
      loadingBuilder: (context, child, progress) {
        if (progress == null) return child;
        return _Placeholder(
          color: fallbackColor,
          child:  SizedBox(
            width: 22,
            height: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.2,
              color: fallbackColor,
              //kalau fultter tau ukuran total file makan akan menghitung proses donwload gambar
              //kalau fultter tdk tau ukuran file makan akan mengambilkan null
              value: progress.expectedTotalBytes != null ? progress.cumulativeBytesLoaded / progress.expectedTotalBytes! : null,
            ),
          ) ,
        );
      },
      //errorbuilder yg akan di panggil kalau proses di atas (loading gambar) gagal total
      errorBuilder: (context, error, stackTrace) {
        return _Placeholder(color: fallbackColor, 
        child: Icon(fallbackIcon, size: 48, color: fallbackColor,)
        );
      },
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.color, required this.child});

  final Color color;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color.withValues(alpha: 0.18),
      alignment: Alignment.center,
      child: child,
    );
  }
}