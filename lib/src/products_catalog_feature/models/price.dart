class Price {
  const Price({required this.amount, required this.currency});

  final String amount;
  final String currency;

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount']?.toString() ?? "",
      currency: json['currency']?.toString() ?? "",
      );
  }
}