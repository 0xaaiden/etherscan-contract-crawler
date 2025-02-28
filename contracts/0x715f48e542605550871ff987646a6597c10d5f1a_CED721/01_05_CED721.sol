// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: connectedoom
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////
//                                                                                     //
//                                                                                     //
//                                                                                     //
//     **       ** ****     ** ********       *       ******** **     ** **********    //
//    /**      /**/**/**   /**/**/////       /*      /**///// //**   ** /////**///     //
//    /**      /**/**//**  /**/**            /*      /**       //** **      /**        //
//    /**      /**/** //** /**/*******       /       /*******   //***       /**        //
//    /**      /**/**  //**/**/**////         *      /**////     **/**      /**        //
//    /**      /**/**   //****/**            /*      /**        ** //**     /**        //
//    /********/**/**    //***/********      /*      /******** **   //**    /**        //
//    //////// // //      /// ////////       /       //////// //     //     //         //
//                                                                                     //
//                                                                                     //
//                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////


contract CED721 is ERC721Creator {
    constructor() ERC721Creator("connectedoom", "CED721") {}
}