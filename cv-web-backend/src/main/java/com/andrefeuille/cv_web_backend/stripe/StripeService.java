package com.andrefeuille.cv_web_backend.stripe;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.stripe.Stripe;
import com.stripe.exception.StripeException;
import com.stripe.model.checkout.Session;
import com.stripe.param.checkout.SessionCreateParams;

import jakarta.annotation.PostConstruct;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class StripeService {

        @Value("${STRIPE_SECRET_KEY}")
        private String secretKey;

        @PostConstruct
        public void init() {
                Stripe.apiKey = secretKey;
        }

        public ChargeResponse checkoutProducts(ChargeRequest chargeRequest) {
                log.info("💸 checkoutProducts called!");

                // Create a PaymentIntent with the order amount and currency
                SessionCreateParams.LineItem.PriceData.ProductData productData = SessionCreateParams.LineItem.PriceData.ProductData
                                .builder()
                                .setName(chargeRequest.getName())
                                .build();

                // Create new line item with the above product data and associated price
                String currency = chargeRequest.getCurrency().toString() != null
                                ? chargeRequest.getCurrency().toString()
                                : ChargeRequest.Currency.EUR.toString();

                SessionCreateParams.LineItem.PriceData priceData = SessionCreateParams.LineItem.PriceData
                                .builder()
                                .setCurrency(currency)
                                .setUnitAmount(chargeRequest.getAmount())
                                .setProductData(productData)
                                .build();

                // Create new line item with the above price data
                SessionCreateParams.LineItem lineItem = SessionCreateParams.LineItem.builder()
                                .setQuantity(chargeRequest.getQuantity())
                                .setPriceData(priceData)
                                .build();

                // Create a new session with the above line item
                SessionCreateParams params = SessionCreateParams.builder()
                                .setMode(SessionCreateParams.Mode.PAYMENT)
                                .setSuccessUrl("http://localhost:8080/success")
                                .setCancelUrl("http://localhost:8080/cancel")
                                .addLineItem(lineItem)
                                .build();

                // Create a new session with the above parameters
                Session session;
                try {
                        session = Session.create(params);
                } catch (StripeException ex) {
                        log.error("💸🔴 StripeException occurred: {}", ex.getMessage());
                        return ChargeResponse.builder()
                                        .status("FAILED")
                                        .message("Stripe error: " + ex.getMessage())
                                        .sessionId(null)
                                        .sessionUrl(null)
                                        .build();
                }

                return ChargeResponse
                                .builder()
                                .status("SUCCESS")
                                .message("Payment session created ")
                                .sessionId(session.getId())
                                .sessionUrl(session.getUrl())
                                .build();
        }

        // @ExceptionHandler(StripeException.class)
        // public ChargeResponse handleStripeException(StripeException ex) {
        // log.error("💸🔴 StripeException occurred: {}", ex.getMessage());
        // return ChargeResponse.builder()
        // .status("FAILED")
        // .message("Stripe error: " + ex.getMessage())
        // .sessionId(null)
        // .sessionUrl(null)
        // .build();
        // }

        // public Charge charge(ChargeRequest chargeRequest)
        // throws AuthenticationException, InvalidRequestException,
        // ApiConnectionException, CardException, ApiException {
        // Map<String, Object> chargeParams = new HashMap<>();
        // chargeParams.put("amount", chargeRequest.getAmount());
        // chargeParams.put("currency", chargeRequest.getCurrency());
        // chargeParams.put("description", chargeRequest.getDescription());
        // chargeParams.put("source", chargeRequest.getStripeToken());
        // return Charge.create(chargeParams);
        // }
}