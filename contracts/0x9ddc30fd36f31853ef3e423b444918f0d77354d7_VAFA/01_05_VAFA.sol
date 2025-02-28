// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: AKAVAFA
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                                                                                   //
//    :::'###::::'##:::'##::::'###::::'##::::'##::::'###::::'########::::'###::::    //
//    ::'## ##::: ##::'##::::'## ##::: ##:::: ##:::'## ##::: ##.....::::'## ##:::    //
//    :'##:. ##:: ##:'##::::'##:. ##:: ##:::: ##::'##:. ##:: ##::::::::'##:. ##::    //
//    '##:::. ##: #####::::'##:::. ##: ##:::: ##:'##:::. ##: ######:::'##:::. ##:    //
//     #########: ##. ##::: #########:. ##:: ##:: #########: ##...:::: #########:    //
//     ##.... ##: ##:. ##:: ##.... ##::. ## ##::: ##.... ##: ##::::::: ##.... ##:    //
//     ##:::: ##: ##::. ##: ##:::: ##:::. ###:::: ##:::: ##: ##::::::: ##:::: ##:    //
//    ..:::::..::..::::..::..:::::..:::::...:::::..:::::..::..::::::::..:::::..::    //
//                                                                                   //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


contract VAFA is ERC721Creator {
    constructor() ERC721Creator("AKAVAFA", "VAFA") {}
}