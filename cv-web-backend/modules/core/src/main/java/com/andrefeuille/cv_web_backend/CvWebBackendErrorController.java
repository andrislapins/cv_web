package com.andrefeuille.cv_web_backend;

import java.util.HashMap;
import java.util.Map;

import org.springframework.boot.web.servlet.error.ErrorController;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.http.HttpServletRequest;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
public class CvWebBackendErrorController implements ErrorController  {

    @RequestMapping("/error-spring")
    public Object handleError(HttpServletRequest request) {
        Object statusObj = request.getAttribute(RequestDispatcher.ERROR_STATUS_CODE);
        int statusCode = statusObj != null ? Integer.parseInt(statusObj.toString()) : 500;

        String acceptHeader = request.getHeader("Accept");
        boolean isBrowser = acceptHeader != null && acceptHeader.contains("text/html");

        String path = (String) request.getAttribute(RequestDispatcher.ERROR_REQUEST_URI);

        String emoji;
        String returnPage = "error";

        if (statusCode >= 500) {
            // Server error
            emoji      = "💥";
        } else if (statusCode == 404) {
            // Not found
            emoji      = "🔍";
            returnPage = "error-404";
        } else if (statusCode == 403) {
            // Forbidden
            emoji      = "⛔";
            returnPage = "error-403";
        } else if (statusCode == 400) {
            // Bad request
            emoji = "⚠️";
        } else {
            // Generic error
            emoji = "❗";
        }

        log.warn("{} Received error status: {} for path {}", emoji, statusCode, path);
        
        if (isBrowser) {
            // Return an HTML error page
            return returnPage;
        }

        // Return a JSON error response
        Map<String, Object> errorBody = new HashMap<>();
        errorBody.put("status", statusCode);
        errorBody.put("message", "Error occurred: " + statusCode);
        
        return ResponseEntity.status(statusCode).body(errorBody);
    }
}