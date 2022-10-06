class TransactionsModel {
  String? status;
  List<Data>? data;

  TransactionsModel({this.status, this.data});

  TransactionsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  String? type;
  num? amount;
  String? phoneNumber;
  String? created;
  num? balance;

  Data({this.type, this.amount, this.phoneNumber, this.created, this.balance});

  Data.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    amount =json['amount'];
    phoneNumber = json['phoneNumber'];
    created = json['created'];
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['type'] = type;
    data['amount'] = amount;
    data['phoneNumber'] = phoneNumber;
    data['created'] = created;
    data['balance'] = balance;
    return data;
  }
}
