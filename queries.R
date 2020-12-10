library(ghql)
library(jsonlite)

con <- GraphqlClient$new(
  url= "https://api.thegraph.com/subgraphs/name/balancer-labs/balancer"
)

qry <- Query$new()

qry$query('private', '{
    pools (where: {active: true, tokensCount_gt: 1, finalized: false, crp: false, tokensList_not: []}, first: 20, skip: 0, orderBy: "liquidity", orderDirection: "desc") {
    symbol
    name
    publicSwap
    swapFee
    totalWeight
    totalShares
    totalSwapVolume
    totalSwapFee
    liquidity
    tokensList
    tokens {
      id
      address
      balance
      decimals
      symbol
      denormWeight
    }
    createTime
    tokensCount
    holdersCount
    joinsCount
    exitsCount
    swapsCount
    swaps {
      tokenAmountIn
      tokenInSym
      tokenAmountOut
      tokenOutSym
      value,
      feeValue,
      poolTotalSwapVolume
      poolTotalSwapFee
      poolLiquidity
      timestamp
    }
  }
}
')

qry$query('smart', '{
    pools (where: {active: true, tokensCount_gt: 1, id_in: ["0x7860e28ebfb8ae052bfe279c07ac5d94c9cd2937", "0x5c0f17b1cfb6225628204e2b8e44239a9cc0ef9f", "0xdd0b69d938c6e98bf8f16f04c4913a0c07e0bb6e", "0x10996ec4f3e7a1b314ebd966fa8b1ad0fe0f8307"], tokensList_not: []}, first: 20, skip: 0, orderBy: "liquidity", orderDirection: "desc") {
    symbol
    name
    publicSwap
    swapFee
    totalWeight
    totalShares
    totalSwapVolume
    totalSwapFee
    liquidity
    tokensList
    tokens {
      id
      address
      balance
      decimals
      symbol
      denormWeight
    }
    createTime
    tokensCount
    holdersCount
    joinsCount
    exitsCount
    swapsCount
    swaps {
      tokenAmountIn
      tokenInSym
      tokenAmountOut
      tokenOutSym
      value,
      feeValue,
      poolTotalSwapVolume
      poolTotalSwapFee
      poolLiquidity
      timestamp
    }
  }
}
')

qry$query('shared', '{
    pools (where: {active: true, tokensCount_gt: 1, finalized: true, tokensList_not: []}, first: 20, skip: 0, orderBy: "liquidity", orderDirection: "desc") {
    symbol
    name
    publicSwap
    swapFee
    totalWeight
    totalShares
    totalSwapVolume
    totalSwapFee
    liquidity
    tokensList
    tokens {
      id
      address
      balance
      decimals
      symbol
      denormWeight
    }
    createTime
    tokensCount
    holdersCount
    joinsCount
    exitsCount
    swapsCount
    swaps {
      tokenAmountIn
      tokenInSym
      tokenAmountOut
      tokenOutSym
      value,
      feeValue,
      poolTotalSwapVolume
      poolTotalSwapFee
      poolLiquidity
      timestamp
    }
  }
}
')

smart_json <- con$exec(qry$queries$smart)
smart <- jsonlite::fromJSON(smart_json)

shared_json <- con$exec((qry$queries$shared))
shared <- jsonlite::fromJSON(shared_json)

private_json <- con$exec((qry$queries$private))
private <- jsonlite::fromJSON(private_json)

saveRDS(smart, "smart.rds")
saveRDS(shared, "shared.rds")
saveRDS(private, "private.rds")


