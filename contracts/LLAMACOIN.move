/// @title AI LLAMA Token Contract
/// @dev Implementation of the AI LLAMA token on SUI Network
module llamacoin::llamacoin {
    use sui::object::{Self, UID};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use std::option;

    const DECIMALS: u8 = 6;
    const SYMBOL: vector<u8> = b"LLAMA";
    const NAME: vector<u8> = b"AI Llama";
    const DESCRIPTION: vector<u8> = b"AI Llama ($LLAMA) is a simple token on the Sui Network. No custom tokenomics.";
    const ICON_URL_STRING: vector<u8> = b"https://salmon-bright-baboon-859.mypinata.cloud/ipfs/bafkreibtt334a723p6qkawq4uj5smsqckjpkq55eyibjhqqqqug3et53qa";

    const INITIAL_SUPPLY: u64 = 100_000_000_000_000_000;

    struct LLAMACOIN has drop {}

    struct TokenConfig has key {
        id: UID,
        owner: address,
        total_supply: u64,
        treasury_cap: sui::coin::TreasuryCap<LLAMACOIN>
    }

    fun init(witness: LLAMACOIN, ctx: &mut TxContext) {
        let sender = tx_context::sender(ctx);
        let (treasury_cap, metadata) = sui::coin::create_currency(
            witness,
            DECIMALS,
            SYMBOL,
            NAME,
            DESCRIPTION,
            option::some(sui::url::new_unsafe_from_bytes(ICON_URL_STRING)),
            ctx
        );

        transfer::public_share_object(metadata);

        let initial_coins = sui::coin::mint(&mut treasury_cap, INITIAL_SUPPLY, ctx);

        let config = TokenConfig {
            id: object::new(ctx),
            owner: sender,
            total_supply: INITIAL_SUPPLY,
            treasury_cap
        };

        transfer::public_transfer(initial_coins, sender);
        transfer::share_object(config);
    }

    public fun get_total_supply(config: &TokenConfig): u64 {
        config.total_supply
    }

    #[test_only]
    public fun init_for_testing(ctx: &mut TxContext) {
        init(LLAMACOIN {}, ctx)
    }

    #[test_only]
    friend llamacoin::llamacoin_test;
}
