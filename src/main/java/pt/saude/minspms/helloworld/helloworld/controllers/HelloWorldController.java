package pt.saude.minspms.helloworld.helloworld.controllers;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/v1/helloworld")
public class HelloWorldController {

  @GetMapping("/greeting")
  public String sayHello(){
    return "Hello World";
  }
}
