package com.andrefeuille.cv_web_backend.stripe;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/product/v1")
public class ChargeController {

    @Autowired
    private final StripeService paymentsService;

    public ChargeController(StripeService paymentsService) {
        this.paymentsService = paymentsService;
    }

    @PostMapping("/checkout")
    public ResponseEntity<ChargeResponse> checkoutProducts(@RequestBody ChargeRequest productRequest) {
        ChargeResponse stripeResponse = paymentsService.checkoutProducts(productRequest);
        return ResponseEntity
                .status(HttpStatus.OK)
                .body(stripeResponse);
    }

    // @PostMapping("/charge")
    // public String charge(ChargeRequest chargeRequest, Model model)
    // throws StripeException {
    // chargeRequest.setDescription("Example charge");
    // chargeRequest.setCurrency(Currency.EUR);
    // Charge charge = paymentsService.charge(chargeRequest);
    // model.addAttribute("id", charge.getId());
    // model.addAttribute("status", charge.getStatus());
    // model.addAttribute("chargeId", charge.getId());
    // model.addAttribute("balance_transaction", charge.getBalanceTransaction());
    // return "result";
    // }

    // @ExceptionHandler(StripeException.class)
    // public String handleError(Model model, StripeException ex) {
    // model.addAttribute("error", ex.getMessage());
    // return "result";
    // }
}