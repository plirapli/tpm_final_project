import 'package:flutter/material.dart';
import 'package:tpm_final_project/views/testimonial/component.dart';

class GetStartedContent extends StatelessWidget {
  const GetStartedContent({super.key});

  static const List<String> textList = [
    "Ketika pengguna pertama kali membuka aplikasi, maka penggunaa akan diarahkan ke halaman login.",
    "Jika pengguna sudah mempunyai akun, pengguna bisa langsung melakukan login dengan cara memasukkan username dan password yang terdaftar, lalu tekan tombol login. Namun, jika pengguna belum memiliki akun, pengguna bisa menekan tombol register yang terdapat di bawah tombol login.",
    "Pada halaman register, pengguna bisa mendaftarkan akun dengan mengisi bagian Nama, Username, dan Password. Jika sudah, tekan tombol register untuk mendaftarkan akun.",
    "Setelah melakukan pendaftaran akun, pengguna akan diarahkan ke halaman login untuk melakukan login.",
    "Setelah berhasil login, pengguna akan dibawa ke halaman utama. Pada halaman ini, terdapat 3 menu utama, yaitu Menu Utama, Menu Stopwatch, dan Menu Profile",
    "Pada Menu Utama, terdapat 5 menu yang menjadi fitur utama dari aplikasi ini, yaitu menu Prime Numbers, Triangle, Premiere League Clubs, Favorite, dan About Me.",
    "Pada Menu Stopwatch, terdapat aplikasi stopwatch yang dapat digunakan untuk mengukur waktu.",
    "Pada Menu Profile, terdapat informasi dari akun yang kita miliki. Di bawahnya juga terdapat 2 tombol, yaitu tombol Help untuk bantuan cara menggunakan aplikasi dan tombol Logout untuk keluar dari akun yang dimiliki user.",
  ];

  @override
  Widget build(BuildContext context) => const ComponentHelp(textList: textList);
}

class PrimeNumberContent extends StatelessWidget {
  const PrimeNumberContent({super.key});

  static const List<String> textList = [
    "Prime Numbers merupakan salah satu fitur dalam aplikasi ini yang berfungsi untuk mengecek apakah suatu bilangan termasuk ke dalam bilangan prima atau bukan.",
    "Pengguna bisa mengakses fitur ini dengan masuk ke menu utama, lalu memilih menu \"Prime Numbers\".",
    "Pengguna akan diminta untuk memasukkan angka di antara 0 sampai dengan 1.000.000.000.000 (1 Triliun).",
    "Setelah pengguna memasukkan angka, pengguna bisa menekan tombol, \"Check\" untuk mengecek apakah angka yang dimasukkan termasuk ke dalam bilangan prima atau bukan.",
    "Jika angka tersebut termasuk bilangan prima, maka akan muncul tulisan \"PRIME\" pada bagian result.",
    "Namun, jika angka tersebut tidak termasuk bilangan prima, maka akan muncul tulisan \"NOT PRIME\".",
    "Jika pengguna tidak memasukkan angka apapun dan langsung menekan tombol \"Check\", maka akan tampil simbol \"😵\"."
  ];

  @override
  Widget build(BuildContext context) => const ComponentHelp(textList: textList);
}

class TriangleContent extends StatelessWidget {
  const TriangleContent({super.key});

  static const List<String> textList = [
    "Triangle merupakan salah satu fitur dalam aplikasi ini yang berfungsi untuk menghitung luas dan keliling dari 3 jenis bangun segitiga, yaitu segitiga siku-siku, sama sisi, dan sama kaki.",
    "Pengguna bisa mengakses fitur ini dengan masuk ke menu utama, lalu memilih menu \"Triangle\".",
    "Pengguna akan diminta untuk memasukkan alas dan tinggi pada form yang tersedia. (Khusus untuk seigitiga sama sisi pengguna cukup memasukkan satu sisinya saja)",
    "Setelah pengguna memasukkan alas dan tinggi, pengguna bisa menekan tombol, \"Calculate\" untuk melihat hasil perhitungan keliling dan luas dari segitiga yang dipilih.",
    "Jika pengguna tidak memasukkan alas atau tinggi dan langsung menekan tombol \"Calculate\", maka akan tampil simbol \"😵\"."
  ];

  @override
  Widget build(BuildContext context) => const ComponentHelp(textList: textList);
}

class ClubsContent extends StatelessWidget {
  const ClubsContent({super.key});

  static const List<String> textList = [
    "Premier League Clubs merupakan salah satu fitur dalam aplikasi ini yang berfungsi untuk menampilkan daftar klub yang berkompetisi di ajang Premier League 2023/2024.",
    "Pengguna bisa mengakses fitur ini dengan masuk ke menu utama, lalu memilih menu \"Premier League Clubs\".",
    "Pengguna dapat melakukan pencarian klub dengan mengetikkan klub yang ingin dicari di kolom pencarian.",
    "Pengguna dapat menekan tombol \"Visit Website\" untuk mengunjungi situs resmi dari klub yang dipilih.",
    "Selain itu, pengguna juga dapat menambahkan klub yang diinginkan ke dalam daftar favorit dengan menekan tombol ❤️.",
    "Pengguna dapat melihat klub yang ditambahkan ke dalam daftar favorit dengan masuk ke menu utama, lalu memilih menu \"Favorite Clubs\""
  ];

  @override
  Widget build(BuildContext context) => const ComponentHelp(textList: textList);
}

class StopwatchContent extends StatelessWidget {
  const StopwatchContent({super.key});

  static const List<String> textList = [
    "Stopwatch merupakan salah satu fitur dalam aplikasi ini yang berfungsi untuk mengukur waktu.",
    "Pengguna bisa mengakses fitur ini dengan masuk ke menu \"Stopwatch\" yang berada di tengah.",
    "Pengguna dapat memulai pengukuran waktu dengan menekan tombol \"start\" ▶️.",
    "Pengguna juga dapat menghentikan pengukuran waktu dengn menekan tombol \"pause\" ⏸️.",
    "Selain itu, pengguna dapat, serta mengatur ulang pengukuran waktu dengan menekan tombol \"reset\"."
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: textList.map((text) => _text(text)).toList(),
    );
  }

  Widget _text(String text) {
    return Container(
      margin: const EdgeInsets.only(top: 8),
      child: Text(text, style: const TextStyle(fontSize: 16)),
    );
  }
}
