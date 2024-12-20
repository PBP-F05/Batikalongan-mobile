// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

List<Store> storeFromJson(String str) => List<Store>.from(json.decode(str).map((x) => Store.fromJson(x)));

String storeToJson(List<Store> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Store {
    Model model;
    String pk;
    Fields fields;

    Store({
        required this.model,
        required this.pk,
        required this.fields,
    });

    factory Store.fromJson(Map<String, dynamic> json) => Store(
        model: modelValues.map[json["model"]]!,
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
    );

    Map<String, dynamic> toJson() => {
        "model": modelValues.reverse[model],
        "pk": pk,
        "fields": fields.toJson(),
    };
}

class Fields {
    String name;
    String address;
    int storeCount;
    String image;

    Fields({
        required this.name,
        required this.address,
        required this.storeCount,
        required this.image,
    });

    factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        name: json["name"],
        address: json["address"],
        storeCount: json["store_count"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "store_count": storeCount,
        "image": image,
    };
}

enum Model {
    CATALOG_STORE
}

final modelValues = EnumValues({
    "catalog.store": Model.CATALOG_STORE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}