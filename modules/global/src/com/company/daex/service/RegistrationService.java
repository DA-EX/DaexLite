package com.company.daex.service;


public interface RegistrationService {
    String NAME = "daex_RegistrationService";

    public void RegistrationUser(String SecondName, String FirstName, String Email, String Password);
    public boolean CheckUser(String login);
    public void SendEmail(String email,Integer code);
}