# Toy Storey Mobile
## Tugas 9
#### Jelaskan mengapa kita perlu membuat model untuk melakukan pengambilan ataupun pengiriman data JSON? Apakah akan terjadi error jika kita tidak membuat model terlebih dahulu?
Model diperlukan untuk mempermudah strukturisasi, validasi, dan pemeliharaan data JSON, karena model memetakan data menjadi objek yang terorganisir, memastikan format dan tipe data sesuai, serta membuat kode lebih terstruktur dan mudah dipahami. Tanpa model, aplikasi tetap dapat memproses data JSON, tetapi cenderung rawan kesalahan seperti salah akses, ketidaksesuaian tipe data, atau kompleksitas pengelolaan ketika skala aplikasi bertambah. Oleh karena itu, meskipun tidak wajib, model sangat disarankan untuk efisiensi dan keandalan dalam pengolahan data JSON.
#### Jelaskan fungsi dari library http yang sudah kamu implementasikan pada tugas ini
Library http berfungsi untuk mempermudah interaksi dengan server melalui protokol HTTP, seperti mengirim permintaan (GET, POST, PUT, DELETE) dan menerima respons dari API. Library ini memungkinkan aplikasi untuk mengambil data dari server, biasanya dalam format JSON, serta mengirimkan data ke server dengan cara yang efisien dan terstruktur, sehingga mempermudah integrasi antara aplikasi dan layanan backend.
####  Jelaskan fungsi dari CookieRequest dan jelaskan mengapa instance CookieRequest perlu untuk dibagikan ke semua komponen di aplikasi Flutter.
`CookieRequest` dari package `pbp_django_auth` berfungsi untuk mengelola autentikasi dengan menyimpan sesi pengguna melalui cookie, sehingga memungkinkan aplikasi untuk melakukan request HTTP secara aman dan efisien tanpa harus menyertakan informasi autentikasi secara manual di setiap request. Instance `CookieRequest` perlu dibagikan ke semua komponen aplikasi Flutter agar status login dan informasi autentikasi pengguna tetap konsisten di seluruh aplikasi, memungkinkan pengalaman pengguna yang mulus dan mendukung akses data secara stateful di berbagai bagian aplikasi.
#### Jelaskan mekanisme pengiriman data mulai dari input hingga dapat ditampilkan pada Flutter.
1. Input Data: 
   Pengguna memasukkan data melalui antarmuka input di Flutter, seperti pada halaman `product_entry_form.dart`, menggunakan widget form untuk menangkap informasi.

2. Mengirim Request:
   Setelah pengguna menekan tombol submit, data dari form dikirim ke server Django menggunakan package `http` atau `CookieRequest`. Data ini dikirim dalam format JSON melalui metode HTTP seperti POST.

3. Proses di Backend:  
   - Django menerima request melalui endpoint yang didefinisikan di `urls.py`.  
   - Logika pengolahan data dilakukan di `views.py`, seperti validasi, pengolahan data, atau penyimpanan ke database.  
   - Setelah diproses, Django mengembalikan respons ke Flutter, biasanya dalam format JSON.

4. Menerima Respons:  
   Flutter menerima respons dari server, yang biasanya berisi data yang berhasil diproses atau pesan status.

5. Decode Data:  
   Data JSON dari respons dikonversi menjadi objek Dart menggunakan model yang telah dibuat, sehingga mudah diakses dan digunakan.

6. Menampilkan Data:  
   Data yang telah dikonversi ditampilkan pada tampilan Flutter, seperti dalam daftar produk atau elemen UI lainnya, menggunakan widget seperti `ListView` atau `Text`.
#### Jelaskan mekanisme autentikasi dari login, register, hingga logout. Mulai dari input data akun pada Flutter ke Django hingga selesainya proses autentikasi oleh Django dan tampilnya menu pada Flutter.
**Proses Login**  
1. Input Data:  
   Pengguna memasukkan email dan password di halaman login pada aplikasi Flutter.  

2. Mengirim Request:  
   Ketika tombol login diklik, data dikirimkan ke endpoint login di Django menggunakan `CookieRequest` dalam format JSON.  

3. Proses Backend:  
   - Django memverifikasi data pengguna melalui model autentikasi bawaan.  
   - Jika credential valid, Django membuat sesi dan mengembalikan cookie autentikasi kepada Flutter.  

4. Menyimpan Status:  
   `CookieRequest` pada Flutter menyimpan cookie tersebut untuk autentikasi otomatis pada request berikutnya.  

5. Tampilan Menu:  
   Setelah login berhasil, aplikasi Flutter menampilkan menu utama yang sesuai dengan status login pengguna.  

---

**Proses Register**  
1. Input Data:  
   Pengguna memasukkan data pendaftaran, seperti nama, email, dan password, melalui halaman register.  

2. Mengirim Request:  
   Setelah tombol register diklik, data dikirim ke endpoint register Django menggunakan `http` atau `CookieRequest` dalam format JSON.  

3. Proses Backend:  
   - Django memproses data pendaftaran dan menyimpannya ke database menggunakan model pengguna.  
   - Jika validasi berhasil, Django mengembalikan respons sukses.  

4. Notifikasi:  
   Aplikasi Flutter menampilkan pesan sukses atau error berdasarkan respons dari Django. Jika berhasil, pengguna diarahkan ke halaman login.  

---

**Proses Logout**  
1. **Request Logout:  
   Saat tombol logout diklik, Flutter mengirimkan request ke endpoint logout di Django menggunakan `CookieRequest`.  

2. Hapus Cookie:  
   Django menghapus sesi pengguna di server, sehingga cookie tidak lagi valid.  

3. Update Status:  
   Flutter memperbarui status aplikasi menjadi tidak login dengan menghapus informasi sesi.  

4. Navigasi:  
   Pengguna diarahkan kembali ke halaman login, dan menu yang memerlukan autentikasi tidak lagi dapat diakses.
### Step-by-step Implementasi Checklist
#### Mengimplementasikan fitur registrasi akun pada proyek tugas Flutter.
1. Membuat new app `authentication` pada proyek django dan menambahkan views untuk registrasi.
2. Membuat page `register.dart` yang berisi form input username, password, dan konfirmasi password.
3. Membuat logic jika button registrasi di click
```
...
onPressed: () async {
    String username = _usernameController.text;
    String password1 = _passwordController.text;
    String password2 = _confirmPasswordController.text;

    final response = await request.postJson(
        "http://127.0.0.1:8000/auth/register/",
        jsonEncode({
          "username": username,
          "password1": password1,
          "password2": password2,
        }));
...
}
```
4. Routing ke `LoginPage()` jika registrasi berhasil

```
if (response['status'] == 'success') {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Successfully registered!'),
    ),
  );
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
        builder: (context) => const LoginPage()),
  );
}
```
#### Membuat halaman login pada proyek tugas Flutter.
1. Menambahkan views untuk registrasi dalam app `authentication` pada proyek django.
2. Membuat page `login.dart` yang berisi form input username dan password.
3. Membuat logic jika button login di click

```
...
 onPressed: () async {
    String username = _usernameController.text;
    String password = _passwordController.text;

    final response = await request
        .login("http://127.0.0.1:8000/auth/login/", {
      'username': username,
      'password': password,
    });
    ...
 }
 ```
 4. Routing ke `MyHomePage()` jika registrasi berhasil

 ```
 ...
 if (request.loggedIn) {
    String message = response['message'];
    String uname = response['username'];
    if (context.mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => MyHomePage()),
      );
      ...
    }
 }
 ```
#### Mengintegrasikan sistem autentikasi Django dengan proyek tugas Flutter.
1. Membuat app `authentication` yang berisi views login, logout, dan registrasi.
2. Mengambil response dari request login, logout dan registrasi di Flutter
- *Login*

```
final response = await request
      .login("http://127.0.0.1:8000/auth/login/", {
    'username': username,
    'password': password,
  });
```
- *logout*

```
final response = await request.logout(
    "http://127.0.0.1:8000/auth/logout/");
```
- *Registrasi*

```
final response = await request.postJson(
    "http://127.0.0.1:8000/auth/register/",
    jsonEncode({
      "username": username,
      "password1": password1,
      "password2": password2,
    }));
```
3. Memproses response sesuai login, logout, dan resgistrasi

#### Membuat model kustom sesuai dengan proyek aplikasi Django.
1. Membuat model dart menggunakan website Quicktype sesuai json dari model django
2. Membuat file model `product_entry.dart` yang berisi model dari Quicktype
#### Membuat halaman yang berisi daftar semua item yang terdapat pada endpoint JSON di Django yang telah kamu deploy.
Membuat page `list_productentry.dart` untuk fetch json produk dan menampilkannya
- Fetch

```
Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json/');
    
    // Melakukan decode response menjadi bentuk json
    var data = response;
    
    // Melakukan konversi data json menjadi object ProductEntry
    List<ProductEntry> listMood = [];
    for (var d in data) {
      if (d != null) {
        listMood.add(ProductEntry.fromJson(d));
      }
    }
    return listMood;
  }
```
- Menampilkan Produk

```
body: FutureBuilder(
  future: fetchProduct(request),
  builder: (context, AsyncSnapshot snapshot) {
  ... (Menampilkan name, price, dan description)
})
```
#### Membuat halaman detail untuk setiap item yang terdapat pada halaman daftar Item.
1. Membuat page `product_datails.dart` untuk menampilkan datail-datil produk.
2. Membuat logic jika card produk di `list_product` di click, routing ke `ProductDetailsPage` dengan passing product data.

```
onTap: () {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => ProductDetailsPage(
        product: snapshot.data![index], // Pass the product data
      ),
    ),
  );
},
```
3. Menampilkan data sesuai produk pada halaman `ProductDetailsPage`

```
body: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Price: ${product.fields.price}",
        ),
        const SizedBox(height: 10),
        Text("Description: ${product.fields.description}"),
        const SizedBox(height: 10),
        Text("Stock: ${product.fields.stock}"),
      ],
    ),
  ),
```
#### Melakukan filter pada halaman daftar item dengan hanya menampilkan item yang terasosiasi dengan pengguna yang login.
Filter sudah dihandle oleh view `show_json` jason di proyek django

```
def show_json(request):
    data = Product.objects.filter(user=request.user)
    return HttpResponse(
        serializers.serialize("json", data), content_type="application/json"
    )
```
#### 
## Tugas 8
#### Apa kegunaan `const` di Flutter? Jelaskan apa keuntungan ketika menggunakan `const` pada kode Flutter. Kapan sebaiknya kita menggunakan `const`, dan kapan sebaiknya tidak digunakan?
Dalam Flutter, const digunakan untuk mendeklarasikan objek atau nilai yang tidak berubah, yang menawarkan beberapa keuntungan, terutama dalam meningkatkan performa dan efisiensi aplikasi. Dengan const, objek dibuat sekali pada waktu kompilasi dan bersifat immutable, sehingga mengurangi beban pada proses rendering dan penggunaan memori, karena Flutter tidak perlu membuat ulang objek tersebut setiap kali widget dibangun ulang. Penggunaan const sangat bermanfaat pada widget statis seperti teks atau ikon yang tidak berubah, dan nilai tetap yang diketahui pada waktu kompilasi, karena memungkinkan Flutter mengoptimalkan proses rendering. Namun, const sebaiknya tidak digunakan pada widget atau variabel yang nilainya ditentukan secara dinamis atau dapat berubah berdasarkan interaksi pengguna, seperti widget dengan data yang diperbarui atau properti dalam StatefulWidget.

#### Jelaskan dan bandingkan penggunaan Column dan Row pada Flutter. Berikan contoh implementasi dari masing-masing layout widget ini!
Di Flutter, Column dan Row adalah widget layout yang digunakan untuk menyusun anak-anaknya secara vertikal dan horizontal. Column mengatur widget secara vertikal dari atas ke bawah, sedangkan Row mengatur widget secara horizontal dari kiri ke kanan. Keduanya memiliki parameter mainAxisAlignment untuk mengatur penyusunan elemen di sepanjang arah utama (vertikal pada Column dan horizontal pada Row) dan crossAxisAlignment untuk penyusunan elemen di sumbu seberangnya.

#### Sebutkan apa saja elemen input yang kamu gunakan pada halaman form yang kamu buat pada tugas kali ini. Apakah terdapat elemen input Flutter lain yang tidak kamu gunakan pada tugas ini? Jelaskan!
##### Elemen input yang digunakan dalam form:
- TextFormField: Untuk memasukkan nama, jumlah, dan deskripsi produk.
- ElevatedButton: Untuk menyimpan data setelah form divalidasi.
- Elemen input Flutter lain yang tidak digunakan:

##### Checkbox: Untuk input pilihan ya/tidak.
- Radio: Untuk memilih satu dari beberapa opsi.
- Switch: Untuk input boolean (true/false).
- DropdownButtonFormField: Untuk memilih satu opsi dari daftar.
- Slider: Untuk memilih nilai dalam rentang tertentu.
- DatePicker: Untuk memilih tanggal.
- TimePicker: Untuk memilih waktu.

#### Bagaimana cara kamu mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten? Apakah kamu mengimplementasikan tema pada aplikasi yang kamu buat?
Mengatur tema (theme) dalam aplikasi Flutter agar aplikasi yang dibuat konsisten dengan set theme pada `main.dart`  Widget build.

```
theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.lightBlue,
        ).copyWith(secondary: Colors.lightBlueAccent),
        useMaterial3: true,
      ),
```
#### Bagaimana cara kamu menangani navigasi dalam aplikasi dengan banyak halaman pada Flutter?
Dalam tugas ini navigasi halaman-halaman menggunakan left_drawer dengan Widget Drawer. Untuk navigasi dari drawer ke halaman lain menggunakan(contoh ke halaman home):

```
onTap: () {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyHomePage(),
        ));
  },
```

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