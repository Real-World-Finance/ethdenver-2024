import React from 'react';
import Image from "next/image";
import Link from "next/link";
import { useRouter } from "next/router";
import InvestmentCard, { Investment } from "../components/InvestmentCard";
import type { NextPage } from "next";
import { mock } from "wagmi/connectors";
import { BugAntIcon, MagnifyingGlassIcon } from "@heroicons/react/24/outline";

const mockUrl = "https://daisyui.com/images/stock/photo-1606107557195-0e29a4b5b4aa.jpg";
const mockDescription =
  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
export const mockInvestment: Investment = {
  name: "Fund 1",
  description: mockDescription,
  imageUrl: mockUrl,
  price: 100,
  id: "1",
};
const mockInvestments: Investment[] = [
  mockInvestment,
  {
    name: "Fund 2",
    description: mockDescription,
    imageUrl: mockUrl,
    price: 100,
    id: "2",
  },
  {
    name: "Fund 3",
    description: mockDescription,
    imageUrl: mockUrl,
    price: 100,
    id: "3",
  },
  {
    name: "Fund 4",
    description: mockDescription,
    imageUrl: mockUrl,
    price: 100,
    id: "4",
  },
  {
    name: "Fund 5",
    description: mockDescription,
    imageUrl: mockUrl,
    price: 100,
    id: "5",
  },
  {
    name: "Fund 6",
    description: mockDescription,
    imageUrl: mockUrl,
    price: 100,
    id: "6",
  },
];

const Home: NextPage = () => {
  return (
    <div className="flex justify-around">
      <div className="grid lg:grid-cols-3 lg:gap-4 md:grid-cols-2 sm:grid-cols-1 gap-x-4 gap-y-6">
        {mockInvestments?.length &&
          mockInvestments.map(investment => <InvestmentCard key={investment.name} investment={investment} />)}
        {/* <div className="px-5">
          <h1 className="text-center mb-8">
            <span className="block text-2xl mb-2">Welcome to</span>
            <span className="block text-4xl font-bold">Scaffold-ETH 2</span>
          </h1>
          <p className="text-center text-lg">
            Get started by editing{" "}
            <code className="italic bg-base-300 text-base font-bold max-w-full break-words break-all inline-block">
              packages/nextjs/app/page.tsx
            </code>
          </p>
          <p className="text-center text-lg">
            Edit your smart contract{" "}
            <code className="italic bg-base-300 text-base font-bold max-w-full break-words break-all inline-block">
              YourContract.sol
            </code>{" "}
            in{" "}
            <code className="italic bg-base-300 text-base font-bold max-w-full break-words break-all inline-block">
              packages/hardhat/contracts
            </code>
          </p>
        </div>

        <div className="flex-grow bg-base-300 w-full mt-16 px-8 py-12">
          <div className="flex justify-center items-center gap-12 flex-col sm:flex-row">
            <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
              <BugAntIcon className="h-8 w-8 fill-secondary" />
              <p>
                Tinker with your smart contract using the{" "}
                <Link href="/debug" passHref className="link">
                  Debug Contract
                </Link>{" "}
                tab.
              </p>
            </div>
            <div className="flex flex-col bg-base-100 px-10 py-10 text-center items-center max-w-xs rounded-3xl">
              <MagnifyingGlassIcon className="h-8 w-8 fill-secondary" />
              <p>
                Explore your local transactions with the{" "}
                <Link href="/blockexplorer" passHref className="link">
                  Block Explorer
                </Link>{" "}
                tab.
              </p>
            </div>
          </div>
        </div> */}
      </div>
    </div>
  );
};

export default Home;
