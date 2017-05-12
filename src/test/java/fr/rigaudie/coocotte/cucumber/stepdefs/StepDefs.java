package fr.rigaudie.coocotte.cucumber.stepdefs;

import fr.rigaudie.coocotte.CoocotteApp;

import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.ResultActions;

import org.springframework.boot.test.context.SpringBootTest;

@WebAppConfiguration
@SpringBootTest
@ContextConfiguration(classes = CoocotteApp.class)
public abstract class StepDefs {

    protected ResultActions actions;

}
