# Marketplace Billing Overview

We'll be utilizing [Stripe Connect](https://stripe.com/docs/connect) to collect and disburse payments for transactions in our marketplace.

## Overview

A user (stripe customer) will purchase a listing (stripe charge) using their credit card (stripe payment method) from the seller (stripe managed account).

## Stripe Customers
When a user adds a payment method, we'll need to create the customer at the same time.  Any user with a payment method on file, whether they have made a purchase or not, will exist in Stripe.

## Managed Stripe Accounts
[Documentation](https://stripe.com/docs/connect/managed-accounts#creating-a-managed-account)

When a user (seller) posts a listing, we'll need to setup a Managed Connect Account.  This will include creating the account that includes all required verification information from the onset, and accepting Strips ToS on behalf of the seller - all via the Stripe API.

More about account verification [can be read here](https://stripe.com/docs/connect/identity-verification).
Required minimum fields [for creating managed account](https://stripe.com/docs/connect/required-verification-information#minimum-verification-requirements-for-united-states) can be reviewed, but are listed below.

Example request [can be found here](https://stripe.com/docs/connect/testing-verification#creating-a-managed-account).

* TOS Acceptance (date and IP provided manually ourselves, not required to show user)
* Type - business or individual
* Business or Individual Name (first/last)
* Complete Mailing address
* Date of birth
* Last 4 of SSN (for individual, or for the person authorized to setup the business)
* Routing and Account number to US based bank account

## Processing a Transaction

[Documentation](https://stripe.com/docs/connect/payments-fees#charging-through-the-platform)

When the user attempts to purchase the listing, we'll create a purchase transaction in stripe to pull funds from their default payment method already present in Stripe, for the listing price, depositing the funds to the seller's Managed Stripe Connect Account.

This Stripe Charge will be marked as destined to the sellers Managed Account, with an `application_fee` specified that will be money kept for EquusHub, the Stripe fees for the transaction will come out of EquusHub, and the remaining balance of the transaction total will flow to the seller's Managed Account.

## Seller Deposits

Stripe performs a daily deposit of funds (total from previous day) to the Managed Account's connected account (ACH bank in our case).
