class GalleryEntry {
  final String id;
  final String namaBatik;
  final String deskripsi;
  final String asalUsul;
  final String makna;
  final String fotoUrl;

  GalleryEntry({
    required this.id,
    required this.namaBatik,
    required this.deskripsi,
    required this.asalUsul,
    required this.makna,
    required this.fotoUrl,
  });

  factory GalleryEntry.fromJson(Map<String, dynamic> json) {
    return GalleryEntry(
      id: json['pk'],
      namaBatik: json['fields']['nama_batik'],
      deskripsi: json['fields']['deskripsi'],
      asalUsul: json['fields']['asal_usul'],
      makna: json['fields']['makna'],
      fotoUrl: json['fields']['foto'],
    );
  }
}
