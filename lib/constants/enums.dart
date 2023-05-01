enum UserFields { userName, txID, cID, authorization, department }

// enum Authorization {
//   admin,
//   manager,
//   salesman,
//   noAccessDefined;

//   const Authorization();

//   factory Authorization.fromString(String value) {
//     return Authorization.values.firstWhere((element) => element.name == value,
//         orElse: () => Authorization.noAccessDefined);
//   }
// }

enum InsightPageType {
  interval('During selected period'),
  last7Days('Last 7 Days'),
  lastDay('On last selected day');

  final String pageTitle;
  const InsightPageType(this.pageTitle);
}

enum Comparisons {
  moreThen,
  lessThen,
  exact,
  moreThenEquals,
  lessThenEquals;
}

enum Role {
  admin('Admin', adminSubRole, true),
  manager('Manager', managerSubRole, true),
  customerCare('CustomerCare', customerCareSubRole, true),
  sales('Sales', salesSubRole, false),
  marketing('Marketing', marketingSubRole, false),
  delivery('Delivery', deliverySubRole, false),
  nan('undefiled', [], false);

  final String viewName;
  final List<String> roleField;
  final bool privileged;

  const Role(this.viewName, this.roleField, this.privileged);
  factory Role.fromString(String data) => Role.values.firstWhere(
      (element) => element.name.toLowerCase() == data.toLowerCase(),
      orElse: () => Role.nan);
}

const List<String> adminSubRole = [
  'SuperAdmin',
  'BankingAdmin',
];

const List<String> managerSubRole = [
  'FinTech',
  'AgriTech',
  'GoldTech',
  'Loan',
  'Investment',
  'SuperCard'
];

const List<String> salesSubRole = [
  'FinTech',
  'AgriTech',
  'GoldTech',
  'Loan',
  'Investment',
  'SuperCard'
];

const List<String> marketingSubRole = [
  'FinTech',
  'AgriTech',
  'GoldTech',
  'Loan',
  'Investment',
  'SuperCard'
];

const List<String> deliverySubRole = [
  'AgriTech',
  'GoldTech',
  'Loan',
];

const List<String> customerCareSubRole = [
  'FinTech',
  'AgriTech',
  'GoldTech',
  'Loan',
  'Investment',
  'SuperCard'
];
