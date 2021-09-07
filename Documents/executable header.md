Executable header size is 16 bytes.

| Byte | Content |
|---|---|
| 0 | 0x45 executable identifier 'E' |
| 1	| 0x58 executable identifier 'X' |
| 2 | size in RAM in KB |
| 3	| CRC8 of file excl. the header |
| 4	| process type: 0 = normal, 1 = background service |
| 5	| priority (0-3, 0 = highest) |
| 6-15 | unused for now |
