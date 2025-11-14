# Faucet-Code-
On sepolia eth, a faucet contract that gives out pyusd on testnet

 PYUSD Faucet Contract

A simple ERC-20 faucet that distributes PYUSD (PayPal USD) on Ethereum (Sepolia).  
Users can request a fixed amount of PYUSD after every lock-time interval.

---

📌 Contract Information

Token (PYUSD) Address(testnet)
0xCaC524BcA292aaade2DF8A05cC58F0a65B1B3bB9

Faucet Contract Deployment Address
0xb22591647DF1372aE39594caDa99D8872B238897

---

🚀 Features

- Distributes PYUSD to users.
- Adjustable withdrawal amount (owner-only).
- Adjustable cooldown time per wallet.
- Prevents spam by locking each user for a set time.
- Owner can withdraw all tokens anytime.
- Tracks total token balance inside the contract.

---

🧩 How It Works

requestTokens()
Users call this function to receive the faucet’s PYUSD.

Requirements:
- Contract must have enough tokens.
- Caller must wait until their lock time expires.

setWithdrawalAmount(uint256 amount)
Owner sets distribution amount (1 = 1 PYUSD).  
Contract adjusts to *6 decimals automatically*.

setLockTime(uint256 minutesAmount)
Owner sets cooldown time in minutes.

withdrawTokens()
Owner withdraws all remaining PYUSD in the contract.

getBalance()
Returns the faucet’s PYUSD balance.

---

🔢 PYUSD Decimals

PYUSD uses **6 decimals*, so:

| Display | Actual on-chain |
|---------|-----------------|
| 1 PYUSD | 1,000,000       |
| 10 PYUSD | 10,000,000     |
| 0.5 PYUSD | 500,000       |

---

🧪 How to Fund the Faucet

To load the faucet with PYUSD:

1. Open MetaMask or your wallet.
2. Add PYUSD if not added.
3. Send PYUSD to:

0xb22591647DF1372aE39594caDa99D8872B238897

The contract does not reject token transfers — tokens will appear immediately.

---

🛠 How to Interact on Remix

1. Copy the faucet ABI and contract address.
2. Connect MetaMask to Ethereum Sepolia.
3. Use these functions:
   - requestTokens()
   - getBalance()
   - setWithdrawalAmount(amount) (owner)
   - setLockTime(minutes)
   - withdrawTokens() (owner)

---

🔒 Security Notes

- Anyone can request tokens, but only after their cooldown.
- Owner functions are protected with onlyOwner.
- Contract does not hold ETH — only PYUSD.

---

📄 License
MIT License. Free to modify and reuse.

