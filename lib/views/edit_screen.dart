import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crud/views/main_screen.dart';
import 'package:flutter/material.dart';

class EditScreen extends StatefulWidget {
  static const routeName = '/form-edit';

  const EditScreen({Key? key}) : super(key: key);

  @override
  State<EditScreen> createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _hargaController = TextEditingController();
  final TextEditingController _deskripsiController = TextEditingController();
  final TextEditingController _jamController = TextEditingController();
  final TextEditingController _lokasiController = TextEditingController();
  final TextEditingController _imageController = TextEditingController();

  final CollectionReference _wisata =
      FirebaseFirestore.instance.collection('wisata');

  @override
  Widget build(BuildContext context) {
    final place =
        ModalRoute.of(context)!.settings.arguments as DocumentSnapshot;

    if (place != null) {
      _namaController.text = place["nama"];
      _hargaController.text = place["harga_tiket"].toString();
      _deskripsiController.text = place["deskripsi"];
      _jamController.text = place["jam_operasional"];
      _lokasiController.text = place["lokasi"];
      _imageController.text = place["image_url"];
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Update Wisata"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 30),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Nama Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _namaController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Deskripsi Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _deskripsiController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Lokasi Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _lokasiController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Jam Operasional Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _jamController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Harga Tiket Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _hargaController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Image URL Wisata"),
                    SizedBox(
                      height: 5,
                    ),
                    TextField(
                      controller: _imageController,
                      decoration: InputDecoration(border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  child: Text("Update Wisata"),
                  onPressed: () async {
                    final String? nama = _namaController.text;
                    final double? harga_tiket =
                        double.parse(_hargaController.text);
                    final String? deskripsi = _deskripsiController.text;
                    final String? jam_operasional = _jamController.text;
                    final String? lokasi = _lokasiController.text;
                    final String? image_url = _imageController.text;

                    await _wisata.doc(place.id).update({
                      "nama": nama,
                      "harga_tiket": harga_tiket,
                      "deskripsi": deskripsi,
                      "jam_operasional": jam_operasional,
                      "lokasi": lokasi,
                      "image_url": image_url
                    });

                    _namaController.text = "";
                    _hargaController.text = "";
                    _deskripsiController.text = "";
                    _jamController.text = "";
                    _lokasiController.text = "";
                    _imageController.text = "";

                    Navigator.pushReplacementNamed(
                        context, MainScreen.routeName);

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content:
                            Text('You have successfully update a wisata')));
                  },
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all(
                      EdgeInsets.all(12),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
