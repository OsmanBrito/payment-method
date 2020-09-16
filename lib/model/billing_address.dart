class BillingAddress {
  String address;
  String number;
  String neighborhood;
  String complement;
  String city;
  String state;
  String cep;
  String country;

  BillingAddress(
      {this.address,
      this.number,
      this.neighborhood,
      this.complement,
      this.city,
      this.state,
      this.cep,
      this.country});

  BillingAddress.fromJson(Map<String, dynamic> json) {
    address = json['address'];
    number = json['number'];
    neighborhood = json['neighborhood'];
    complement = json['complement'];
    city = json['city'];
    state = json['state'];
    cep = json['cep'];
    country = json['country'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['address'] = this.address;
    data['number'] = this.number;
    data['neighborhood'] = this.neighborhood;
    data['complement'] = this.complement;
    data['city'] = this.city;
    data['state'] = this.state;
    data['cep'] = this.cep;
    data['country'] = this.country;
    return data;
  }
}
