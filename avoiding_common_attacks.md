To avoid some of the attacks, I did the followings:

1. Using Specific Compiler Pragma
2. Use Modifiers Only for Validation
3. Checks-Effects-Interactions (Avoiding state changes after external calls)
4. Timestamp Dependence not used in critical places
5. Tx.Origin Authentication was never used
