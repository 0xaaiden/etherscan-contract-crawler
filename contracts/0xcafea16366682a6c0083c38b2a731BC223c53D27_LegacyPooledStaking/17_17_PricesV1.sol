// SPDX-License-Identifier: GPL-3.0-only

pragma solidity ^0.8.18;

contract PricesV1 {

  function getV1PriceForProduct(uint id) pure public returns (uint96) {

    // V1_PRICES_HELPER_BEGIN

    if (id == 0) { // 0xB27F1DB0a7e473304A5a06E54bdf035F671400C0
      return 2167; // 21.660148 %
    }

    if (id == 1) { // 0x11111254369792b2Ca5d084aB5eEA397cA8fa48B
      return 1255; // 12.543210 %
    }

    if (
      id == 2 || // 0x7d2768dE32b0b80b7a3454c06BdAc94A69DDc7A9
      id == 4 || // 0x5C6374a2ac4EBC38DeA0Fc1F8716e5Ea1AdD94dd
      id == 6 || // 0xfdA462548Ce04282f4B6D6619823a7C64Fdc0185
      id == 8 || // 0x0000000000000000000000000000000000000031
      id == 11 || // 0xBA12222222228d8Ba445958a75a0704d566BF2C8
      id == 14 || // 0x453D4Ba9a2D594314DF88564248497F7D74d6b2C
      id == 17 || // 0x0000000000000000000000000000000000000018
      id == 19 || // 0xc57D000000000000000000000000000000000008
      id == 20 || // 0x3d9819210A31b4961b30EF54bE2aeD79B9c9Cd3B
      id == 21 || // 0x0000000000000000000000000000000000000014
      id == 22 || // 0xF403C135812408BFbE8713b5A23a04b3D48AAE31
      id == 26 || // 0x79a8C46DeA5aDa233ABaFFD40F3A0A2B1e5A4F27
      id == 28 || // 0x364508A5cA0538d8119D3BF40A284635686C98c4
      id == 29 || // 0x0000000000000000000000000000000000000023
      id == 31 || // 0x0000000000000000000000000000000000000032
      id == 33 || // 0x0000000000000000000000000000000000000028
      id == 34 || // 0x0000000000000000000000000000000000000017
      id == 36 || // 0x0000000000000000000000000000000000000030
      id == 38 || // 0x3D6bA331e3D9702C5e8A8d254e5d8a285F223aba
      id == 44 || // 0xA39739EF8b0231DbFA0DcdA07d7e29faAbCf4bb2
      id == 45 || // 0x35D1b3F3D7966A1DFe207aa4514C12a259A0492B
      id == 47 || // 0x0000000000000000000000000000000000000027
      id == 58 || // 0xCC88a9d330da1133Df3A7bD823B95e52511A6962
      id == 59 || // 0x25751853Eab4D0eB3652B5eB6ecB102A2789644B
      id == 60 || // 0x34CfAC646f301356fAa8B21e94227e3583Fe3F5F
      id == 64 || // 0xB17640796e4c27a39AF51887aff3F8DC0daF9567
      id == 67 || // 0xc2EdaD668740f1aA35E4D8f227fB8E17dcA888Cd
      id == 68 || // 0xC011a73ee8576Fb46F5E1c5751cA3B9Fe0af2a6F
      id == 70 || // 0x60aE616a2155Ee3d9A68541Ba4544862310933d4
      id == 71 || // 0x5C69bEe701ef814a2B6a3EDD4B1652CB9cc5aA6f
      id == 72 || // 0x1F98431c8aD98523631AE4a59f267346ea31F984
      id == 73 || // 0x0000000000000000000000000000000000000021
      id == 75 || // 0x9D25057e62939D3408406975aD75Ffe834DA4cDd
      id == 77    // 0x0000000000000000000000000000000000000019
    ) {
      return 260; // 2.600000 %
    }

    if (id == 3) { // 0xd96f48665a1410C0cd669A88898ecA36B9Fc2cce
      return 4351; // 43.508103 %
    }

    if (id == 7) { // 0xB1dD690Cc9AF7BB1a906A9B5A94F94191cc553Ce
      return 1678; // 16.771307 %
    }

    if (id == 10) { // 0x6354E79F21B56C11f48bcD7c451BE456D7102A36
      return 1659; // 16.586650 %
    }

    if (id == 13) { // 0x0000000000000000000000000000000000000022
      return 5286; // 52.852432 %
    }

    if (id == 15) { // 0xC57d000000000000000000000000000000000007
      return 496; // 4.957111 %
    }

    if (id == 18) { // 0x0CED6166873038Ac0cc688e7E6d19E2cBE251Bf0
      return 1175; // 11.745855 %
    }

    if (id == 23) { // 0x0000000000000000000000000000000000000013
      return 1676; // 16.758887 %
    }

    if (id == 25) { // 0x0000000000000000000000000000000000000009
      return 284; // 2.839908 %
    }

    if (id == 27) { // 0x0000000000000000000000000000000000000010
      return 361; // 3.601499 %
    }

    if (id == 39) { // 0x8481a6EbAf5c7DABc3F7e09e44A89531fd31F822
      return 904; // 9.034961 %
    }

    if (id == 41) { // 0xc57d000000000000000000000000000000000009
      return 294; // 2.934402 %
    }

    if (id == 43) { // 0x0000000000000000000000000000000000000033
      return 225; // 2.250000 %
    }

    if (id == 46) { // 0xAFcE80b19A8cE13DEc0739a1aaB7A028d6845Eb3
      return 533; // 5.328265 %
    }

    if (id == 49) { // 0x1344A36A1B56144C3Bc62E7757377D288fDE0369
      return 1466; // 14.650444 %
    }

    if (id == 51) { // 0x7C06792Af1632E77cb27a558Dc0885338F4Bdf8E
      return 3112; // 31.110663 %
    }

    if (id == 52) { // 0x0000000000000000000000000000000000000016
      return 8307; // 83.061670 %
    }

    if (id == 53) { // 0xefa94DE7a4656D787667C749f7E1223D71E9FD88
      return 6006; // 60.053587 %
    }

    if (id == 54) { // 0xA51156F3F1e39d1036Ca4ba4974107A1C1815d1e
      return 3659; // 36.586260 %
    }

    if (id == 55) { // 0xd89a09084555a7D0ABe7B111b1f78DFEdDd638Be
      return 2578; // 25.770105 %
    }

    if (id == 56) { // 0x48D49466CB2EFbF05FaA5fa5E69f2984eDC8d1D7
      return 3091; // 30.903312 %
    }

    if (id == 61) { // 0x5B67871C3a857dE81A1ca0f9F7945e5670D986Dc
      return 2838; // 28.378550 %
    }

    if (id == 62) { // 0xa4c8d221d8BB851f83aadd0223a8900A6921A349
      return 378; // 3.770927 %
    }

    if (id == 63) { // 0x0000000000000000000000000000000000000029
      return 200; // 2.000000 %
    }

    if (id == 65) { // 0x0000000000000000000000000000000000000026
      return 230; // 2.300000 %
    }

    if (id == 66) { // 0x0000000000000000000000000000000000000025
      return 210; // 2.100000 %
    }

    if (id == 74) { // 0xa4F1671d3Aee73C05b552d57f2d16d3cfcBd0217
      return 2687; // 26.869606 %
    }

    // V1_PRICES_HELPER_END

    return type(uint96).max;
  }

}