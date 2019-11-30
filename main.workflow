workflow "co2 emissions" {
  resolves = "validate results"
}

action "download data" {
  uses = "popperized/bin/curl@master"
  args = [
    "--create-dirs",
    "-Lo workflows/minimal-python/data/global.csv",
    "https://github.com/datasets/co2-fossil-global/raw/master/global.csv"
  ]
}

action "run analysis" {
  needs = "download data"
  uses = "jefftriplett/python-actions@master"
  args = [
    "scripts/get_mean_by_group.py",
    "data/global.csv",
    "5"
  ]
}
action "validate results" {
  needs = "run analysis"
  uses = "jefftriplett/python-actions@master"
  args = [
    "scripts/validate_output.py",
    "data/global_per_capita_mean.csv"
  ]
}
