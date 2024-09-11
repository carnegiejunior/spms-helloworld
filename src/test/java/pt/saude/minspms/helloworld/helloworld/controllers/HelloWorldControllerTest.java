package pt.saude.minspms.helloworld.helloworld.controllers;

import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.WebMvcTest;
import org.springframework.test.web.servlet.MockMvc;

import static org.springframework.test.web.servlet.request.MockMvcRequestBuilders.get;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.content;
import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.status;

@WebMvcTest(HelloWorldController.class)
class HelloWorldControllerTest {

  @Autowired
  MockMvc mockMvc;
  @Test
  void shouldReturnHelloWorld() throws Exception {
    mockMvc.perform(get("/api/v1/helloworld/greeting"))
        .andExpect(status().isOk())  // Verifica se o status da resposta é 200 OK
        .andExpect(content().string("Hello World"));  // Verifica se o conteúdo da resposta é "Hello World"
  }
}