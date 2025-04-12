package com.andrefeuille.cv_web_backend.stripe;

import lombok.Data;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class ChargeRequest {

    public enum Currency {
        EUR, USD;
    }

    private String description;
    private Currency currency;

    private Long amount;
    private Long quantity;
    private String name;
    private String stripeEmail;
    private String stripeToken;
}