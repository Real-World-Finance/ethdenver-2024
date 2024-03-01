import React from 'react';
import Image from "next/image";
import { XMarkIcon } from "@heroicons/react/20/solid";
import { Investment } from "~~/components/InvestmentCard";

type Props = {
  investment: Investment;
};

export default function InvestmentDetailsBanner({ investment }: Props) {
  return (
    <div className="relative isolate flex flex-row-reverse items-center gap-x-6 overflow-hidden bg-gray-50 px-6 py-2.5 sm:px-3.5 sm:before:flex-1 h-lvh">
      <div className="flex flex-col w-1/2">
        <div className="flex flex-row items-center">
          <Image src={investment.imageUrl} alt={investment.name} width={100} height={100} style={{ marginRight: 30 }} />
          <h1 className="font-semibold text-4xl leading-6 text-gray-900 mb-0">{investment.name}</h1>
        </div>

        <p className="text-md leading-6 text-gray-900">{investment.description}</p>
        <p className="text-2xl leading-6 text-gray-900 text-right">${investment.price}</p>
      </div>
      <div
        className="absolute left-[max(-7rem,calc(50%-52rem))] top-1/2 -z-10 -translate-y-1/2 transform-gpu blur-2xl"
        aria-hidden="true"
      >
        <div
          className="aspect-[577/310] w-[36.0625rem] bg-gradient-to-r from-[#ff80b5] to-[#9089fc] opacity-30"
          style={{
            clipPath:
              "polygon(74.8% 41.9%, 97.2% 73.2%, 100% 34.9%, 92.5% 0.4%, 87.5% 0%, 75% 28.6%, 58.5% 54.6%, 50.1% 56.8%, 46.9% 44%, 48.3% 17.4%, 24.7% 53.9%, 0% 27.9%, 11.9% 74.2%, 24.9% 54.1%, 68.6% 100%, 74.8% 41.9%)",
          }}
        />
      </div>
      <div
        className="absolute left-[max(45rem,calc(50%+8rem))] top-1/2 -z-10 -translate-y-1/2 transform-gpu blur-2xl"
        aria-hidden="true"
      >
        <div
          className="aspect-[577/310] w-[36.0625rem] bg-gradient-to-r from-[#ff80b5] to-[#9089fc] opacity-30"
          style={{
            clipPath:
              "polygon(74.8% 41.9%, 97.2% 73.2%, 100% 34.9%, 92.5% 0.4%, 87.5% 0%, 75% 28.6%, 58.5% 54.6%, 50.1% 56.8%, 46.9% 44%, 48.3% 17.4%, 24.7% 53.9%, 0% 27.9%, 11.9% 74.2%, 24.9% 54.1%, 68.6% 100%, 74.8% 41.9%)",
          }}
        />
      </div>
    </div>
  );
}
