/**
 * This file is autogenerated by Scaffold-ETH.
 * You should not edit it manually or your changes might be overwritten.
 */
import { GenericContractsDeclaration } from "~~/utils/scaffold-eth/contract";

const deployedContracts = {
  31337: {
    TokenFactory: {
      address: "0x2279B7A0a67DB372996a5FaB50D91eAA73d2eBe6",
      abi: [
        {
          inputs: [
            {
              internalType: "address",
              name: "_trust",
              type: "address",
            },
          ],
          stateMutability: "nonpayable",
          type: "constructor",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "owner",
              type: "address",
            },
          ],
          name: "OwnableInvalidOwner",
          type: "error",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "account",
              type: "address",
            },
          ],
          name: "OwnableUnauthorizedAccount",
          type: "error",
        },
        {
          anonymous: false,
          inputs: [
            {
              indexed: true,
              internalType: "address",
              name: "previousOwner",
              type: "address",
            },
            {
              indexed: true,
              internalType: "address",
              name: "newOwner",
              type: "address",
            },
          ],
          name: "OwnershipTransferred",
          type: "event",
        },
        {
          inputs: [
            {
              internalType: "string",
              name: "name",
              type: "string",
            },
            {
              internalType: "string",
              name: "symbol",
              type: "string",
            },
            {
              internalType: "uint256",
              name: "maxTokens",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "initialPrice",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "dueDate",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "expectedROI",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "earlyWithdrawPenalty",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "pctCashReserve",
              type: "uint256",
            },
            {
              internalType: "uint256",
              name: "profitPct",
              type: "uint256",
            },
            {
              internalType: "string",
              name: "imageUrl",
              type: "string",
            },
          ],
          name: "createToken",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [],
          name: "getTokens",
          outputs: [
            {
              internalType: "contract RWF_Trust[]",
              name: "",
              type: "address[]",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "owner",
          outputs: [
            {
              internalType: "address",
              name: "",
              type: "address",
            },
          ],
          stateMutability: "view",
          type: "function",
        },
        {
          inputs: [],
          name: "renounceOwnership",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
        {
          inputs: [
            {
              internalType: "address",
              name: "newOwner",
              type: "address",
            },
          ],
          name: "transferOwnership",
          outputs: [],
          stateMutability: "nonpayable",
          type: "function",
        },
      ],
      inheritedFunctions: {},
    },
  },
} as const;

export default deployedContracts satisfies GenericContractsDeclaration;
