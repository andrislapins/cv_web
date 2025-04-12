package com.andrefeuille.cv_web_backend.stripe;

import lombok.Data;
import lombok.Builder;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ChargeResponse {
    private String status;
    private String message;
    private String sessionId;
    private String sessionUrl;
}
