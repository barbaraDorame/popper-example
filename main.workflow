workflow "co2 emissions" {
  resolves = "run analysis"
}

action "download data" {
  uses = "actions/bin/sh@master"
  runs = [
    "curl", "--create-dirs", "-Lo data/global.csv",
    "https://github.com/datasets/co2-fossil-global/raw/master/global.csv"
  ]
}

action "run analysis" {
  needs = "download data"
  uses = "actions/bin/sh@master"
  runs = [
    "python", "scripts/get_mean_by_group.py", "data/global.csv", "5"
  ]
}
