# Razorpay Integration Hook Points (admin_panel_web)

This admin panel implements a Bookztron-like UI with a Cart and Orders flow. Payment integration is intentionally not wired. Use these hook points to add Razorpay:

Where to integrate:
1) Create backend order
   - Triggered from: lib/widgets/bill_details_card.dart (Checkout button)
   - Action: POST to backend to create a Razorpay orderId with total amount (cart.totalCents), currency.
   - Response: orderId, amount, currency, keyId.

2) Open Razorpay Checkout (Web)
   - Use Razorpay's JS SDK on web builds or a Flutter plugin that supports web.
   - Options:
     {
       key: "<keyId>",
       amount: <amount_in_paise>,
       currency: "INR",
       name: "Bookztron",
       order_id: "<orderId>",
       prefill: { email: "<user email>" },
       notes: { ... }
     }

3) Verify and capture
   - On success callback, POST from client to backend with:
     - razorpay_order_id
     - razorpay_payment_id
     - razorpay_signature
   - Backend verifies signature, captures the payment, and creates a Purchase record (uses /purchases endpoints).

4) Update UI
   - Clear cart (cartProvider.clear()) upon confirmed success.
   - Navigate to Orders page.

Files to examine:
- lib/widgets/bill_details_card.dart (Checkout button placeholder)
- lib/providers/cart_provider.dart (cart totals)
- lib/providers/orders_provider.dart (Orders list)

Environment:
- Ensure API base is set in .env (BACKEND_BASE_URL). Do not hardcode keys in frontend.
