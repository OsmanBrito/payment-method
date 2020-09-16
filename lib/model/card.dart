class CreditCard {
  String number;
  String expirationDate;
  String securityCode;

  CreditCard({this.number, this.expirationDate, this.securityCode});

  CreditCard.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    expirationDate = json['expirationDate'];
    securityCode = json['securityCode'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['number'] = this.number;
    data['expirationDate'] = this.expirationDate;
    data['securityCode'] = this.securityCode;
    return data;
  }
}
