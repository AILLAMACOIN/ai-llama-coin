# Technical Documentation

## Contract Structure

### Constants
- `DECIMALS`: 6 (standard for SUI tokens)
- `SYMBOL`: "LLAMA"
- `NAME`: "AI Llama"
- `INITIAL_SUPPLY`: 100,000,000,000.000000 LLAMA

### Structs
1. `LLAMACOIN`
   - Witness type for coin creation
   - Has `drop` ability

2. `TokenConfig`
   - Stores token configuration
   - Contains treasury cap
   - Tracks total supply
   - Stores owner address

### Functions
1. `init`
   - Initializes the token
   - Creates currency
   - Mints initial supply
   - Sets up configuration

2. `get_total_supply`
   - Public view function
   - Returns total token supply

## Security Features
- No mint function after initialization
- Public shared configuration
- Transparent metadata
- Standard SUI implementation
