package com.andrefeuille.cv_web_backend;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(controllers = TestController.class)
@ActiveProfiles("test")
class TestControllerTests {

    @Autowired
    private MockMvc mockMvc;

    @Test
    void testEndpointShouldReturnHello() throws Exception {
        mockMvc.perform(get("/test"))
               .andExpect(status().isOk())
               .andExpect(content().string("Hello from test endpoint!"));
    }

    @Test
    void unknownEndpointShouldReturn404() throws Exception {
        mockMvc.perform(get("/does-not-exist"))
               .andExpect(status().isNotFound());
    }
}
