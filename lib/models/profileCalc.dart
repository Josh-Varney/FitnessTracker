// BMI Formula
double calculateBMI(double weight, double height) {
  double heightInMeters = height / 100;

  // Formula
  double bmi = weight / (heightInMeters * heightInMeters);

  return bmi;
}

// BMR Formula
double calculateBMR(double weight, double height, int age) {
  return 88.362 + (13.397 * weight) + (4.799 * height) - (5.677 * age);
}

// Protein Formula
double calculateProteinRequirement(double weight) {
  const double proteinPerKg = 1.6;

  double proteinRequirement = proteinPerKg * weight;

  return proteinRequirement;
}
