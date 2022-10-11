%lang starknet

from starkware.cairo.common.alloc import alloc
from starkware.cairo.common.cairo_builtins import HashBuiltin
from starkware.cairo.common.uint256 import Uint256

from openzeppelin.token.erc721.library import ERC721
from contracts.utils.ShortString import uint256_to_ss
from contracts.utils.Array import concat_arr

//
// Storage
//

@storage_var
func ERC721_base_contractURI(index: felt) -> (res: felt) {
}

@storage_var
func ERC721_base_contractURI_len() -> (res: felt) {
}

func ERC721_contractURI{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}() -> (
    tokenURI_len: felt, tokenURI: felt*
) {
    alloc_locals;
    let (local contract_uri: felt*) = alloc();
    let (local contract_uri_len: felt) = ERC721_base_contractURI_len.read();
    _ERC721_baseContractURI(contract_uri_len, contract_uri);
    return (contract_uri_len, contract_uri);
}

func _ERC721_baseContractURI{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    base_contractURI_len: felt, base_contractURI: felt*
) {
    if (base_contractURI_len == 0) {
        return ();
    }
    let (base) = ERC721_base_contractURI.read(base_contractURI_len);
    assert [base_contractURI] = base;
    _ERC721_baseContractURI(
        base_contractURI_len=base_contractURI_len - 1, base_contractURI=base_contractURI + 1
    );
    return ();
}

func ERC721_setBaseContractURI{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    contractURI_len: felt, contractURI: felt*
) {
    _ERC721_setBaseContractURI(contractURI_len, contractURI);
    ERC721_base_contractURI_len.write(contractURI_len);
    return ();
}

func _ERC721_setBaseContractURI{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    contractURI_len: felt, contractURI: felt*
) {
    if (contractURI_len == 0) {
        return ();
    }
    ERC721_base_contractURI.write(index=contractURI_len, value=[contractURI]);
    _ERC721_setBaseContractURI(contractURI_len=contractURI_len - 1, contractURI=contractURI + 1);
    return ();
}
