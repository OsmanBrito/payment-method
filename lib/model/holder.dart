class Holder {
  String name;
  String cpf;

  Holder({this.name, this.cpf});

  Holder.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    cpf = json['cpf'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['cpf'] = this.cpf;
    return data;
  }
}
