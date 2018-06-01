month = {
  "january" => 31,
  "february" => 28,
  "march" => 30,
  "april" => 30,
  "may" => 31,
  "june" => 30,
  "jule" => 31,
  "august" => 31,
  "september" => 30,
  "october" => 31,
  "november" => 30,
  "december" => 31
}

month.each_key { |key| puts key if month[key] == 30 }
