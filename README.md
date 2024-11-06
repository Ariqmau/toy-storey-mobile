# Toy Storey Mobile
## Tugas 7
#### Jelaskan apa yang dimaksud dengan stateless widget dan stateful widget, dan jelaskan perbedaan dari keduanya.
##### Stateless widget
Stateless widget adalah widget yang tidak memiliki state atau kondisi yang berubah selama lifecycle-nya. Artinya, setelah widget dibuat, tampilannya akan tetap sama dan tidak berubah seiring waktu atau interaksi pengguna. Stateless widget hanya memperbarui tampilannya ketika objek widget diganti secara eksplisit.
##### Stateful widget
Stateful widget adalah widget yang memiliki state, atau kondisi internal, yang bisa berubah selama lifecycle-nya. Widget ini dapat merespons perubahan, seperti input dari pengguna, atau peristiwa eksternal lainnya. Ketika state-nya berubah, widget akan di-rebuild untuk mencerminkan perubahan tersebut.
#### Sebutkan widget apa saja yang kamu gunakan pada proyek ini dan jelaskan fungsinya.
- MaterialApp:       Root dari aplikasi yang menyediakan tema dan pengaturan dasar.
- ThemeData:         Menentukan tema aplikasi, termasuk warna utama dan warna sekunder.
- Scaffold:          Struktur dasar halaman dengan AppBar dan body.
- AppBar:            Menampilkan header halaman dengan judul "Toy Storey".
- Padding:           Memberi jarak di sekitar konten dalam body.
- Column:            Menyusun widget secara vertikal.
- Text:              Menampilkan teks, seperti judul aplikasi dan pesan selamat datang.
- GridView.count:    Membuat grid dengan jumlah kolom tetap, menampilkan item dalam bentuk grid.
- Material:       	 Menyediakan efek material seperti latar belakang dan radius pada ItemCard.
- InkWell:           Memberikan efek ripple dan aksi saat ItemCard ditekan.
- ScaffoldMessenger: Menampilkan pesan SnackBar ketika item ditekan.
- SnackBar:     	 Memberikan notifikasi sementara di bagian bawah layar.
- Container:    	 Menyusun ikon dan teks dalam kartu dengan padding dan alignment.
- Icon:         	 Menampilkan ikon yang mewakili setiap item di ItemCard.
#### Apa fungsi dari `setState()`? Jelaskan variabel apa saja yang dapat terdampak dengan fungsi tersebut.
Fungsi `setState()` digunakan untuk memberi tahu framework bahwa state atau kondisi internal dari suatu widget telah berubah dan perlu di-rebuild untuk memperbarui tampilan. Fungsi ini umumnya dipakai dalam stateful widget untuk memicu pembaruan UI ketika ada perubahan pada variabel atau data yang digunakan dalam tampilan widget tersebut.
Variabel yang dapat terdampak dengan fungsi tersebut:
- Variabel yang Menyimpan Data untuk UI
Misalnya, variabel yang menyimpan angka, teks, daftar, atau data lainnya yang ditampilkan di layar. Contoh variabel ini adalah counter dalam aplikasi penghitungan, yang berubah setiap kali tombol ditekan.
- Status atau Kondisi yang Mengubah Tampilan UI
Variabel boolean yang mengatur apakah elemen UI tertentu ditampilkan atau tidak. Contohnya, variabel isLoading yang digunakan untuk menampilkan loading spinner ketika data sedang di-fetch.
- Variabel untuk Mengontrol Tampilan Interaktif
Variabel yang menyimpan informasi interaktif seperti status input pengguna, pilihan menu, atau posisi slider.
#### Jelaskan perbedaan antara const dengan final.
Kata kunci const dan final digunakan untuk mendefinisikan variabel yang tidak bisa diubah nilainya setelah inisialisasi, namun keduanya berbeda dalam cara penetapan nilai. const menetapkan nilai pada waktu kompilasi (compile-time), yang berarti nilai harus sudah diketahui sebelum program berjalan dan digunakan untuk nilai konstan seperti angka atau string yang pasti. Sebaliknya, final menetapkan nilai pada waktu run-time, memungkinkan inisialisasi nilai yang baru diketahui saat program dijalankan, seperti hasil perhitungan atau input pengguna.
### Step-by-step Implementasi Checklist
#### Membuat sebuah program Flutter baru dengan tema E-Commerce
1. Membuat program Flutter baru dengan menjalankan:
`flutter create toy_storey`
2. Membuat `main.dart` untuk layout tampilan utama dan `menu.dart` untuk menu-menu yang akan ditampilkan di dalam direktori `lib`.
#### Membuat tiga tombol sederhana dengan ikon dan teks
1. Membuat widget ItemHomepage dan ItemCard untuk digunakan dalam pembuatan instance tombol-tombol.
```
class ItemHomepage {
  final String name;
  final IconData icon;
  final Color color;

  ItemHomepage(this.name, this.icon, this.color);
}

class ItemCard extends StatelessWidget {
  // Menampilkan kartu dengan ikon dan nama.

  final ItemHomepage item; 
  
  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menentukan warna tombol
      color: item.color,
        ...
    );
  }
}
```
2. Membuat `items` yang berisi tombol-tombol yang akan ditampilkan

```
final items = [
  ItemHomepage('Products', Icons.shopping_bag, Colors.blue),
  ItemHomepage('Add Product', Icons.add, Colors.green),
  ItemHomepage('Logout', Icons.logout, Colors.red),
];
```
3. Menampilkan tombol di MyHomePage berdasarkan `items`

```
GridView.count(
    primary: true,
    padding: const EdgeInsets.all(20),
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
    crossAxisCount: 3,
    // Agar grid menyesuaikan tinggi kontennya.
    shrinkWrap: true,

    // Menampilkan ItemCard untuk setiap item dalam list items.
    children: items.map((ItemHomepage item) {
        return ItemCard(item);
    }).toList(),
),
```
#### Mengimplementasikan warna-warna yang berbeda untuk setiap tombol (Lihat Daftar Produk, Tambah Produk, dan Logout).
1. Membuat tombol dengan class `ItemHomepage` di dalam items
```
final items = [
  ItemHomepage('Products', Icons.shopping_bag, Colors.blue),
  ItemHomepage('Add Product', Icons.add, Colors.green),
  ItemHomepage('Logout', Icons.logout, Colors.red),
];
```
2. Menggunakan warna tersebut untuk ditampilkan pada `ItemCard`

```
class ItemCard extends StatelessWidget {
  // Menampilkan kartu dengan ikon dan nama.

  final ItemHomepage item; 
  
  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    return Material(
      // Menentukan warna tombol
      color: item.color,
        ...
    );
  }
}
```
#### Memunculkan Snackbar
Pada setiap `ItemCard` ditambahkan `onTap` untuk menampilkan pesan Snackbar sesuai dengan namanya.

```
// Aksi ketika kartu ditekan.
onTap: () {
    // Menampilkan pesan SnackBar saat kartu ditekan.
    ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
        SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
    );
},
```