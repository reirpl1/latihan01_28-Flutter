import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

double hitungTotal(int jumlah, double harga) {
  return jumlah * harga;
}

double hitungHargaAkhir(double total, double persenPotongan) {
  return total - (total * persenPotongan / 100);
}

double bayarAkhir(int jumlah, double harga, double persenPotongan) {
  double total = hitungTotal(jumlah, harga);
  return hitungHargaAkhir(total, persenPotongan);
}

double hitungHarga(bool anggota, double hAnggota, double hUmum ) {
  if (anggota) {
    return hAnggota;
  } else {
    return hUmum;
  }
}

class Barang {
  String nama;
  int harga;
  int stok;

  Barang(this.nama, this.harga, this.stok);

  void tampilkan() {
    print("==== KARTU DATA BARANG ====");
    print("Nama Barang : $nama");
    print("Harga       : Rp$harga");
    print("Jumlah Stok : $stok");

    if (stok > 0) {
      print("Status      : Tersedia");
    } else {
      print("Status      : Tidak Tersedia");
    }
    print("=============================");
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.pink),
      ),
      home: const MyHomePage(title: 'Latihan Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

@override
void initState() {
  super.initState();

  // Deklarasi variabel
  String namaBarang = "Buku Tulis";
  int hargaAnggota = 5000;
  int hargaUmum = 7000;
  int jumlahStok = 90;
  int jumlahBeli = 170;
  bool anggota = true;
  String kategori = "atk";

  Barang bukuTulis = Barang("Buku Tulis", 5000, 90);
  Barang pulpen = Barang("Pulpen", 2500, 50);
  Barang roti = Barang("Roti", 4000, 20);

  List<Barang> daftarBarangObjek
 = [
    bukuTulis,
    pulpen,
    roti,
  ];
  
  for  (Barang barang in daftarBarangObjek) {
    barang.tampilkan();
  }

//  Dibandingkan cara sprint 3 yang menggunakan beberapa List terpisah
//  untuk  nama, harga, stok,  penggunaan objek Barang membuat
//  data setiap  barang menjadi satu kesatuan.
//  Dengan List<Barang> dan perulangan, penambahan barang menjadi
//  lebih mudah  karena cukup membuat objek Barang baru tanpa
//  harus menambah data pada beberapa List yang berbeda.

// Memodelkan barang sebagai objek membuatt data nama, harga, dan stok
// menjadi satu kesatuan sehingga kode lebih rapi. 
// Sistem koperasi lebih mudah dikembangkan karena atribut atau Method
// baru dapat ditambahkan ke class Barang tanpa mengubah banyak kode

  bool tersedia = jumlahStok > 0;
  String rak;

  switch (kategori) {
    case "atk":
      rak = "Rak 1";
      break;
    case "makanan":
      rak = "Rak 2";
      break;
    case "minuman":
      rak = "Rak 3";
      break;
    default:
      rak = "Rak lain";
  }

  // Switch-case lebih rapi digunakan ketika ada banyak pilihan nilai yang tetap,
  // misal seperti kategori barang. Kode menjadi lebih mudah dibaca dan dikelola
  // dibandingkan menggunakan banyak if-else secara berurutan.

  double harga = hitungHarga(
    anggota,
    hargaAnggota.toDouble(),
    hargaUmum.toDouble(),
  );

  // Menghitung total
  double total = hitungTotal(jumlahBeli, harga);

  // Menghitung potongan
  double persenPotongan = 0;
  double hargaAkhir = 0;

  if (total < 0) {
    print("Error: Total belanja tidak boleh bernilai negatif!");
    return;
  }

  if (anggota && total > 500000) {
    persenPotongan = 15;
  } else if (total > 200000) {
    persenPotongan = 10;
  } else if (total > 100000) {
    persenPotongan = 5;
  }
 
  double potongan = total * persenPotongan / 100;

  hargaAkhir = bayarAkhir(
    jumlahBeli,
    harga,
    persenPotongan,
  );

  hargaAkhir = hitungHargaAkhir(total, persenPotongan);
  
  final rupiah = NumberFormat.currency(
  locale: 'id_ID',
  symbol: 'Rp',
  decimalDigits: 0,
);

  // Menampilkan hasil
  print("===== KARTU DATA BARANG =====");
  print("Nama Barang   : $namaBarang");
  print("Harga Anggota : ${rupiah.format(hargaAnggota)}");
  print("Harga Umum    : ${rupiah.format(hargaUmum)}");
  print("Jumlah Stok   : $jumlahStok");
  print("Kategori      : $kategori");
  print("Letak Rak     : $rak");

  if (tersedia) {
    print("Status Barang : Tersedia");
  } else {
    print("Status Barang : Tidak Tersedia");
  }

  print("Status Pembeli : ${anggota ? "Anggota" : "Umum"}");
  print("Harga Satuan   : ${rupiah.format(harga)}");
  print("Jumlah Beli    : $jumlahBeli");
  print("Total Harga    : ${rupiah.format(total)}");
  print("Potongan       : ${rupiah.format(potongan)} ($persenPotongan%)");
  print("Harga Akhir    : ${rupiah.format(hargaAkhir)}");
  print("=============================");


// ==============================
// DAFTAR BARANG
// ==============================

List<String> daftarBarang = [
  "Buku Tulis",
  "Pulpen",
  "Penghapus",
  "Roti",
];

List<int> daftarHarga = [
  3000,
  2500,
  1500,
  5000,
];

List<int> daftarStok = [
  3,
  50,
  2,
  20,
];

int totalNilaiStok = 0;

for (int i = 0; i <daftarBarang.length; i++) {
  totalNilaiStok += daftarHarga[i] * daftarStok[i];
}

print("");
print("==== TOTAL NILAI STOK ====");
print("Total Nilai Stok : ${rupiah.format(totalNilaiStok)}");

print("");
print("==== BARANG DENGAN STOK MENIPIS ====");

for (int i = 0; i < daftarBarang.length; i++) {
  if (daftarStok[i] < 5) {
    print("${daftarBarang[i]} - Stok: ${daftarStok[i]}");
  }
}

print("");
print("===== DAFTAR BARANG =====");

for (int i = 0; i < daftarBarang.length; i++) {
  print("${i + 1}. ${daftarBarang[i]} - ${rupiah.format(daftarHarga[i])}");
}

print("");
print("---- PENJUALAN BUKU TULIS ----");

int stokBuku = 3;

// Jika kondisi while  salah, program dapat terus melakukan penjualan
// hingga stok menjadi negatif atau terjadi perulangan tanpa henti
// dengan menggunakan kondisi while (stokBuku > 0), penjualan hanya dilakukan
// selama stok masih tersedia dan akan berhenti tepat saat stok habis

while (stokBuku > 0) {
  stokBuku--;
  print("Terjual 1, sisa stok: $stokBuku");
}

}

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}


//Pemilihan tipe data yang tepat penting agar data pada kasir koperasi akurat dan mudah diolah.
//Misalnya harga dan stok menggunakan int, nama barang menggunakan string dan status tersedia menggunakan bool.
//Dengan tipe data yang sesuai, kesalahan perhitungan dan penyimpanan data dapat diminimalkan.

// Memecah program menjadi fungsi membuat kode lebih mudah dipelihara dan digunakan kembali
// Jika aturan potongan koperasi berubah, cukup mengubah perhitungan pada fungsi
// hitungHargaAkhir() tanpa perlu mengubah kode dibagian transaksi lainnya. 
// Dengan demikian, perubahan cukup  dilakukan satu kali sehingga lebih efisien 
// dan mengurangi risiko kesalahan.

// Memindahkan logika pemilihan harga ke fungsi hitungHargga()
// mengurangi risiko kesalahan karena keputusan hanya dibuat
// di satu tempat, jika aturan harga anggota atau umum berubah,
// cukup mengubah fungsi hitungHarga() tanpa mengubah seluruh
// bagian proram yang menggunakan harga tersebut

// Fungsi bayarAkhir menyusun beberapa fungsi menjadi satu proses
// Fungsi ini memanggil hitungTotal() lalu hitungHargaAkhir() sehingga
// kode mnejadi lebih rapi, mudah digunakan kembali, dan perubahan
// cukup dilakukan pada fungsi terkait tanpa mengubah banyak bagian program

