// @dart=2.10
//     final availableRoomModel = availableRoomModelFromJson(jsonString);

import 'dart:convert';

AvailableRoomModel availableRoomModelFromJson(String str) =>
    AvailableRoomModel.fromJson(json.decode(str));

String availableRoomModelToJson(AvailableRoomModel data) =>
    json.encode(data.toJson());

class AvailableRoomModel {
  AvailableRoomModel({
    this.data,
  });

  List<Datum> data;

  factory AvailableRoomModel.fromJson(Map<String, dynamic> json) =>
      AvailableRoomModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  Datum({
    this.id,
    this.productId,
    this.roomId,
    this.room,
    this.outlet,
  });

  int id;
  int productId;
  int roomId;
  Room room;
  Outlet outlet;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        productId: json["product_id"],
        roomId: json["room_id"],
        room: Room.fromJson(json["room"]),
        outlet: Outlet.fromJson(json["outlet"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "room_id": roomId,
        "room": room.toJson(),
        "outlet": outlet.toJson(),
      };
}

class Outlet {
  Outlet({
    this.id,
    this.posOutletId,
    this.roomId,
    this.createdAt,
    this.updatedAt,
    this.posOutlets,
  });

  int id;
  int posOutletId;
  int roomId;
  DateTime createdAt;
  DateTime updatedAt;
  PosOutlets posOutlets;

  factory Outlet.fromJson(Map<String, dynamic> json) => Outlet(
        id: json["id"],
        posOutletId: json["pos_outlet_id"],
        roomId: json["room_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        posOutlets: PosOutlets.fromJson(json["pos_outlets"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pos_outlet_id": posOutletId,
        "room_id": roomId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pos_outlets": posOutlets.toJson(),
      };
}

class PosOutlets {
  PosOutlets({
    this.id,
    this.name,
    this.address,
    this.country,
    this.state,
    this.city,
    this.postcode,
    this.status,
    this.inventorySourceId,
    this.createdAt,
    this.updatedAt,
    this.readerId,
    this.deletedAt,
  });

  int id;
  String name;
  String address;
  String country;
  String state;
  String city;
  String postcode;
  int status;
  int inventorySourceId;
  DateTime createdAt;
  DateTime updatedAt;
  String readerId;
  dynamic deletedAt;

  factory PosOutlets.fromJson(Map<String, dynamic> json) => PosOutlets(
        id: json["id"],
        name: json["name"],
        address: json["address"],
        country: json["country"],
        state: json["state"],
        city: json["city"],
        postcode: json["postcode"],
        status: json["status"],
        inventorySourceId: json["inventory_source_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        readerId: json["reader_id"],
        deletedAt: json["deleted_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "address": address,
        "country": country,
        "state": state,
        "city": city,
        "postcode": postcode,
        "status": status,
        "inventory_source_id": inventorySourceId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "reader_id": readerId,
        "deleted_at": deletedAt,
      };
}

class Room {
  Room({
    this.id,
    this.name,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.posOutletRoom,
    this.productRooms,
  });

  int id;
  String name;
  dynamic deletedAt;
  DateTime createdAt;
  DateTime updatedAt;
  Outlet posOutletRoom;
  List<ProductRoom> productRooms;

  factory Room.fromJson(Map<String, dynamic> json) => Room(
        id: json["id"],
        name: json["name"],
        deletedAt: json["deleted_at"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        posOutletRoom: Outlet.fromJson(json["pos_outlet_room"]),
        productRooms: List<ProductRoom>.from(
            json["product_rooms"].map((x) => ProductRoom.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "deleted_at": deletedAt,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "pos_outlet_room": posOutletRoom.toJson(),
        "product_rooms":
            List<dynamic>.from(productRooms.map((x) => x.toJson())),
      };
}

class ProductRoom {
  ProductRoom({
    this.id,
    this.productId,
    this.roomId,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int productId;
  int roomId;
  DateTime createdAt;
  DateTime updatedAt;

  factory ProductRoom.fromJson(Map<String, dynamic> json) => ProductRoom(
        id: json["id"],
        productId: json["product_id"],
        roomId: json["room_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "product_id": productId,
        "room_id": roomId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
      };
}
