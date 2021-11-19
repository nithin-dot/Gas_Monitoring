class NodeMcu {
  var temperature;
  var humidity;
  var gas;

  NodeMcu({this.temperature, this.humidity, this.gas});

  factory NodeMcu.fromJson(Map<String, dynamic> json) {
    return new NodeMcu(
        temperature: json['temperature'],
        humidity: json['humidity'],
        gas: json['gas']);
  }
}
