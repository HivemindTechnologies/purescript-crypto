{ name = "crypto"
, dependencies =
  [ "assert"
  , "effect"
  , "foldable-traversable"
  , "maybe"
  , "newtype"
  , "node-buffer"
  , "nullable"
  , "prelude"
  , "psci-support"
  ]
, packages = ./packages.dhall
, sources = [ "src/**/*.purs", "test/**/*.purs" ]
}
