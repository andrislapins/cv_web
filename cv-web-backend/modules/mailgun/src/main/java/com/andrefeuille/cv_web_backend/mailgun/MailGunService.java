package com.andrefeuille.cv_web_backend.mailgun;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.util.LinkedMultiValueMap;
import org.springframework.util.MultiValueMap;
import org.springframework.web.reactive.function.BodyInserters;
import org.springframework.web.reactive.function.client.WebClient;
import org.thymeleaf.TemplateEngine;
import org.thymeleaf.context.Context;

@Service
@RequiredArgsConstructor
@Slf4j
public class MailGunService {

  private final TemplateEngine templateEngine;

  private static final String MAILGUN_API_KEY = System.getenv("MAILGUN_API_KEY");
  private static final String MAILGUN_DOMAIN = System.getenv("MAILGUN_DOMAIN");

  private final WebClient webClient = WebClient.builder()
      .baseUrl("https://api.eu.mailgun.net/v3/" + MAILGUN_DOMAIN)
      .defaultHeaders(headers -> {
          headers.setBasicAuth("api", MAILGUN_API_KEY);
          headers.setContentType(MediaType.APPLICATION_FORM_URLENCODED);
      })
      .build();

  public void sendTemplatedEmail(String to, String name) {
    // log.info("🔑 API_KEY={}", MAILGUN_API_KEY);
    // log.info("📬 DOMAIN={}", MAILGUN_DOMAIN);
    // Generate HTML content from Thymeleaf template
    Context context = new Context();
    context.setVariable("name", name);
    String html = templateEngine.process("email/welcome", context);

    // Build form data
    MultiValueMap<String, String> formData = new LinkedMultiValueMap<>();
    formData.add("from", "Mailgun Sandbox <postmaster@" + MAILGUN_DOMAIN + ">");
    formData.add("to", to);
    formData.add("subject", "Welcome to CV Web Backend");
    formData.add("html", html);

    // Send via WebClient
    webClient.post()
        .uri("/messages")
        .body(BodyInserters.fromFormData(formData))
        .retrieve()
        .bodyToMono(String.class)
        .doOnNext(responseBody -> log.info("📧 Email sent to {} — response: {}", to, responseBody))
        .doOnError(err -> log.error("❌ Failed to send email: {}", err.getMessage()))
        .block(); // For synchronous execution
  }
}