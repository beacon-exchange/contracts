module Main where

import RIO

import Solidity as Sol

ittTy :: Sol.Struct
ittTy = Sol.struct "ITT" -- TODO annotation
  [ address "BEACON_CONTRACT"
  , address "base"
  , address "dst"
  , address "sender" -- is this always inferrable from context/sig?
  , uint256 "amount"
  , uint256 "forfeiture_fee"
  , uint256 "challenge_period_seconds"
  , bytes32 "nonce"
  ]

poiTy :: Sol.Struct
poiTy = Sol.struct "POI" -- TODO annotation
  [ address "BEACON_CONTRACT"
  , address "itt_base"
  , address "itt_dst"
  -- uint256 amount; // assume no partial fills for now.
  , bytes32 "itt_hash"
  , bytes32 "nonce"
  ]

main_sol :: Text
main_sol = renderMarkupStrict
  $(Sol.renderFile "templates/Main.sol")

safemath_sol :: Text
safemath_sol = renderMarkupStrict
  $(Sol.renderFile "templates/SafeMath.sol")

main :: IO ()
main = do
  writeFileUtf8Builder "artifacts/sol/Main.sol" (display main_sol)
  writeFileUtf8Builder "artifacts/sol/SafeMath.sol" (display safemath_sol)
