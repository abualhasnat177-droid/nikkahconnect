class PlanModel {
  final int id;
  final String name;
  final double pricePkr;
  final double priceUsd;
  final int durationDays;
  final Map<String, dynamic> features;

  PlanModel({
    required this.id,
    required this.name,
    required this.pricePkr,
    required this.priceUsd,
    required this.durationDays,
    this.features = const {},
  });

  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'free',
      pricePkr: (json['price_pkr'] ?? 0).toDouble(),
      priceUsd: (json['price_usd'] ?? 0).toDouble(),
      durationDays: json['duration_days'] ?? 0,
      features: json['features'] is Map ? Map<String, dynamic>.from(json['features']) : {},
    );
  }
}
