return {
  init_options = {
    command = {
      "golangci-lint",
      "run",
      "--fix=false",
      "--fast",
      "--out-format=json",
    },
  },
}
