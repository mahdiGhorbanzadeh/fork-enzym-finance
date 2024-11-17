// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import "forge-std/Script.sol";
import "./../../../contracts/release/infrastructure/value-interpreter/IValueInterpreter.sol";
import "forge-std/console.sol";
import "./../../../contracts/release/infrastructure/price-feeds/primitives/IChainlinkPriceFeedMixin.sol";

contract AddPrimitives is Script {

    address public constant valueInterpreterAddress = 0xC5fE9A6daCFDA03fE3C8BC9816aba4BE3B7acf99;

    address[] public primitives=[
        0x040d1EdC9569d4Bab2D15287Dc5A4F10F56a56B8,
        0x354A6dA3fcde098F8389cad84b0182725c6C91dE,
        0x11cDb42B0EB46D95f990BeDD4695A6e3fA034978,
        0xaAFcFD42c9954C6689ef1901e03db742520829c5,
        0x9623063377AD1B27544C965cCd7342f7EA7e88C7,
        0x1DEBd73E752bEaF79865Fd6446b0c970EaE7732f,
        0x2416092f143378750bb29b79eD961ab195CcEea5,
        0x2bcC6D6CdBbDC0a4071e48bb3B969b06B3330c07,
        0x2f2a2543B76A4166549F7aaB2e75Bef0aefC5B0f,
        0x3082CC23568eA640225c2467653dB90e9250AaA0,
        0x35751007a407ca6FEFfE80b3cB397736D2cf4dbe,
        0x4186BFC76E2E237523CBC30FD220FE055156b41F,
        0x565609fAF65B92F7be02468acF86f8979423e514,
        0x5979D7b546E38E414F7E9822514be443A4800529,
        0x8f5c1A99b1df736Ad685006Cb6ADCA7B7Ae4b514,
        0x912CE59144191C1204E64559FE8253a0e49E6548,
        0xa9004A5421372E1D83fB1f85b0fc986c912f91f3,
        0xaC800FD6159c2a2CB8fC31EF74621eB430287a5A,
        0xaf88d065e77c8cC2239327C5EDb3A432268e5831,
        0xba5DdD1f9d7F570dc94a51479a000E3BCE967196,
        0xbc011A12Da28e8F0f528d9eE5E7039E22F91cf18,
        0xDA10009cBd5D07dd0CeCc66161FC93D7c9000da1,
        0xEC70Dcb4A1EFa46b8F2D97C310C9c4790ba5ffA8,
        0xf97f4df75117a78c1A5a0DBb814Af92458539FB4,
        0xFa7F8980b0f1E64A2062791cc3b0871572f1F7f0,
        0xfc5A1A6EB076a2C7aD06eD22C90d7E710E35ad0a,
        0xFd086bC7CD5C481DCC9C85ebE478A1C0b69FCbb9,
        0xe50fA9b3c56FfB159cB0FCA61F5c9D750e8128c8,
        0x724dc807b04555b71ed48a6896b6F41593b8C637,
        0x078f358208685046a11C85e8ad32895DED33A249,
        0x8437d7C167dFB82ED4Cb79CD44B7a32A1dd95c77,
        0x513c7E3a9c69cA3e22550eF58AC1C0088e918FFf,
        0x6ab707Aca953eDAeFBc4fD23bA73294241490620,
        0x191c10Aa4AF7C30e871E70C95dB0E4eb77237530,
        0x6533afac2E7BCCB20dca161449A13A32D391fb00,
        0x625E7708f30cA75bfd92586e17077590C60eb4cD,
        0x82E64f49Ed5EC1bC6e43DAD4FC8Af9bb3A2312EE,
        0x8Eb270e296023E9D92081fdF967dDd7878724424,
        0x8ffDf2DE812095b1D19CB146E4c004587C0A0692,
        0xf329e36C7bF6E5E86ce2150875a84Ce77f477375,
        0xeBe517846d0F36eCEd99C735cbF6131e1fEB775D,
        0x38d693cE1dF5AaDF7bC62595A37D667aD57922e5,
        0xe80772Eaf6e2E18B651F160Bc9158b2A5caFCA65,
        0xFF970A61A04b1cA14834A43f5dE4533eBDDB5CC8,
        0x17FC002b466eEc40DaE837Fc4bE5c67993ddBd6F,
        0x5d3a1Ff2b6BAb83b63cd9AD0787074081a52ef34,
        0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2,
        0xf7d4e7273E5015C96728A6b02f31C505eE184603,
        0x93b346b6BC2548dA6A1E7d98E9a421B42541425b,
        0x7dfF72693f6A4149b17e7C6314655f6A9F7c8B33,
        0x050C24dBf1eEc17babE5fc585F06116A259CC77A
    ];
    
    address[] public aggregators = [
        0xBE5eA816870D11239c543F84b71439511D70B94f,
        0xe7C53FFd03Eb6ceF7d208bC4C13446c76d1E5884,
        0xaebDA2c976cfd1eE1977Eac079B4382acb849325,
        0x851175a919f36c8e30197c09a9A49dA932c2CC00,
        0x0F38D86FceF4955B705F35c9e41d1A16e0637c73,
        0xa668682974E3f121185a3cD94f00322beC674275,
        0x11E1836bFF2ce9d6A5bec9cA79dc998210f3886d,
        0x24ceA4b8ce57cdA5058b924B9B9987992450590c,
        0xd0C7101eACbB49F3deCcCc166d238410D6D46d57,
        0x20d0Fcab0ECFD078B036b6CAf1FaC69A6453b352,
        0xE141425bc1594b8039De6390db1cDaf4397EA22b,
        0xb0EA543f9F8d4B818550365d13F66Da747e1476A,
        0x8bf61728eeDCE2F32c456454d87B5d6eD6150208,
        0xb523AE262D20A936BC152e6023996e46FDC2A95D,
        0xD07de6e37A011CCAfD375d7eb130205E0fa24d69,
        0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
        0x6970460aabF80C5BE983C6b74e5D06dEDCA95D4A,
        0x205aaD468a11fd5D34fA7211bC6Bad5b3deB9b98,
        0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
        0xaD1d5344AaDE45F43E596773Bcc4c423EAbdD034,
        0x05Bc6e5Fb110589bb366A3Cd7CdBe143EeBA2168,
        0xc5C8E77B397E531B8EC06BFb0048328B30E9eCfB,
        0xD6aB2298946840262FcC278fF31516D39fF611eF,
        0xb7c8Fb1dB45007F98A68Da0588e1AA524C317f27,
        0x9C917083fDb403ab5ADbEC26Ee294f6EcAda2720,
        0xDB98056FecFff59D032aB628337A4887110df3dB,
        0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7,
        0x639Fe6ab55C921f74e7fac1ee960C0B6293ba612,
        0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
        0xd0C7101eACbB49F3deCcCc166d238410D6D46d57,
        0xE141425bc1594b8039De6390db1cDaf4397EA22b,
        0xb523AE262D20A936BC152e6023996e46FDC2A95D,
        0x3f3f5dF88dC9F13eac63DF89EC16ef6e7E25DdE7,
        0xb7c8Fb1dB45007F98A68Da0588e1AA524C317f27,
        0xb2A824043730FE05F3DA2efaFa1CBbe83fa548D6,
        0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
        0xc5C8E77B397E531B8EC06BFb0048328B30E9eCfB,
        0xD6aB2298946840262FcC278fF31516D39fF611eF,
        0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF,
        0xaD1d5344AaDE45F43E596773Bcc4c423EAbdD034,
        0x3c786e934F23375Ca345C9b8D5aD54838796E8e7,
        0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8,
        0x6548a81E640C000150e06AB413fB3F772682e9c5,
        0x50834F3163758fcC1Df9973b6e91f0F0F0434aD3,
        0x0809E3d38d1B4214958faf06D8b1B1a2b73f2ab8,
        0x88AC7Bca36567525A866138F03a6F6844868E0Bc,
        0xf2215b9c35b1697B5f47e407c917a40D055E68d7,
        0xB4102D5E72c402D537C9f024F4bd9c3709FE200d,
        0x0411D28c94d85A36bC72Cb0f875dfA8371D8fFfF,
        0x3c786e934F23375Ca345C9b8D5aD54838796E8e7,
        0xd0C7101eACbB49F3deCcCc166d238410D6D46d57

    ];

    uint8[] public uint8RateAssets = [
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        1,
        0,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        0,
        1,
        0,
        1,
        1,
        1,
        0,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        1,
        0,
        1,
        1,
        1
    ];

    function convertToRateAsset(uint8[] memory uint8Array) internal pure returns (IChainlinkPriceFeedMixin.RateAsset[] memory) {
        IChainlinkPriceFeedMixin.RateAsset[] memory rateAssetsArray = new IChainlinkPriceFeedMixin.RateAsset[](uint8Array.length);
        
        for (uint256 i = 0; i < uint8Array.length; i++) {
            rateAssetsArray[i] = IChainlinkPriceFeedMixin.RateAsset(uint8Array[i]);
        }

        return rateAssetsArray;
    }

    function run() external {
        
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        
        vm.startBroadcast(deployerPrivateKey);

        IChainlinkPriceFeedMixin.RateAsset[] memory rateAssets = convertToRateAsset(uint8RateAssets);

        IValueInterpreter valueInterpreter = IValueInterpreter(valueInterpreterAddress);

        valueInterpreter.addPrimitives(primitives,aggregators,rateAssets);

        vm.stopBroadcast();

    }
}



