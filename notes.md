## BlockchainReferenceTest_53

stamp           = 80
pc              = 1395
opcode          = CALLCODE
depth           = 0
getRemainingGas = 4503599627343777 = 0x0fffffffff97a1
gas             = µ[0]             = 0x0fffffffff97a1
address         = µ[1]             = 0xca1100f2

stamp           = 88
pc              = 11
opcode          = CALLCODE
depth           = 1
getRemainingGas = 4503599627343777 = 0x0fffffffff97a1
gas             = µ[0]             = 0x0fbfffffff8f30
address         = µ[1]             = 0xca11

Here is the bytecode of the account at address 0xca11:
```bash
PUSH1 0x09
PUSH1 0x08
PUSH1 0x07
PUSH1 0x06
PUSH1 0x05
PUSH1 0x04
PUSH1 0x03
PUSH1 0x02
PUSH1 0x01         # final step in countdown
INVALID
JUMPDEST
JUMPDEST
JUMPDEST
JUMPDEST
JUMPDEST
PUSH4 0xdead60a7   # dead goat ?
PUSH1 0xe0
SHL
PUSH1 0x00
MSTORE
PUSH1 0x20
PUSH1 0x00
RETURN
```

We have a countdown and hit the INVALID opcode thereby consuming all the code
stamp           = 98
pc              = 18
opcode          = INVALID
depth           = 2
getRemainingGas = 4363961650611926 ≡ 0x0f80ffffff86d6

We REVERT
stamp           = 105
pc              = 26
opcode          = REVERT
depth           = 1
getRemainingGas = 69269232549373 ≡ 0x3efffffffdfd

stamp           = 106
pc              = 1396
opcode          = CALLCODE
depth           = 0
getRemainingGas = 4503599627343777 ≡ 0x0fffffffff97a1
gas             = µ[0]             = 0x           // no gas ... will fail
address         = µ[1]             = 0x01         // ECRECOVER

stamp           = 115
pc              = 365
opcode          = REVERT
depth           = 0
getRemainingGas = 139637976726543  ≡ 0x7efffffffc0f
gas             = µ[0]             = 0x00         // offset
address         = µ[1]             = 0x20         // size



Then we get to `traceContextExit`
* leftoverGas = 139637976726543 ≡ 0x7efffffffc0f
* gasRefund   = 0
* txStack.current().getBesuTransaction().getGasLimit() ← 4503599627370496 ≡ 0x10000000000000
