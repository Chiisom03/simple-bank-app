class AccountsModel {
  String? status;
  String? message;
  List<Data>? data;

  AccountsModel({this.status, this.message, this.data});

  AccountsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? phoneNumber;
  num? balance;
  String? created;

  Data({this.phoneNumber, this.balance, this.created});

  Data.fromJson(Map<String, dynamic> json) {
    phoneNumber = json['phoneNumber'];
    balance = json['balance'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['phoneNumber'] = phoneNumber;
    data['balance'] = balance;
    data['created'] = created;
    return data;
  }
}
