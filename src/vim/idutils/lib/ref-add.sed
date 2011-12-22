/^# Packages using this file: / {
  s/# Packages using this file://
  ta
  :a
  s/ idutils / idutils /
  tb
  s/ $/ idutils /
  :b
  s/^/# Packages using this file:/
}
