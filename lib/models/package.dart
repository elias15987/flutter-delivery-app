class Package {
  final int weight;

  Package(this.weight) : assert(weight > 0, 'El peso debe ser mayor que cero');

  @override
  String toString() {
    return 'Package(weight: $weight)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! Package) return false;
    return weight == other.weight;
  }

  @override
  int get hashCode => weight.hashCode;
}
