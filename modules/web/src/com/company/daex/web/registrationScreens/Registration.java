package com.company.daex.web.registrationScreens;

import com.company.daex.service.RegistrationService;
import com.haulmont.bali.util.ParamsMap;
import com.haulmont.cuba.core.app.EmailService;
import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.EmailInfo;
import com.haulmont.cuba.gui.WindowManager;
import com.haulmont.cuba.gui.components.AbstractWindow;
import com.haulmont.cuba.gui.components.TextField;

import javax.inject.Inject;

import java.util.Collections;
import java.util.Map;
import java.util.concurrent.ThreadLocalRandom;

import static com.haulmont.cuba.gui.components.Window.Editor.WINDOW_CLOSE;

public class Registration extends AbstractWindow {

    @Inject
    private TextField textFieldSecondName;
    @Inject
    private TextField textFieldFirstName;
    @Inject
    private TextField textFieldEmail;
    @Inject
    private TextField textFieldPassword;

    @Inject
    private EmailService emailService;
    @Inject
    private DataManager dataManager;

    @Inject
    private RegistrationService registrationService;

    private int Code;

    @Override
    public void init(Map<String, Object> params) {
        Code  = ThreadLocalRandom.current().nextInt(100000, 999998 + 1);
        //items = (Expertise) WindowParams.ITEM.getEntity(params);
        //super.init(params);
    }

    public void onSubmitBtnClick(){
        //Verification Screen = null;
        //CheckNullPointer
        if(CheckField() ==true) {
            if(registrationService.CheckUser(getLogin()))
            {
                registrationService.SendEmail(getLogin(),Code);
                Verification Screen = (Verification) openWindow("verification", WindowManager.OpenType.DIALOG,
                        ParamsMap.of(
                                "SecondName", textFieldSecondName.getValue().toString(),
                                "FirstName", textFieldFirstName.getValue().toString(),
                                "Email", textFieldEmail.getValue().toString().toLowerCase(),
                                "Code", Code,
                                "Password",textFieldPassword.getValue().toString()
                        ));

                Screen.addCloseListener(listener ->
                {
                    super.close(WINDOW_CLOSE);
                });
            }
            else{
                showNotification("Такой пользователь уже существует!" ,NotificationType.ERROR_HTML);
            }
        }
        else
            showNotification("Проверте заполнение полей!" ,NotificationType.ERROR_HTML);


    }

    public void onCancelBtnClick(){
        super.close(WINDOW_CLOSE);
    }

    private boolean CheckField(){
        if(textFieldSecondName != null && textFieldFirstName != null && textFieldEmail != null && textFieldPassword!=null)
        {
            if(     textFieldSecondName.getValue() != null &&
                    textFieldFirstName.getValue() != null &&
                    textFieldEmail.getValue() != null &&
                    textFieldPassword.getValue()!= null){

                if(     textFieldSecondName.getValue().toString().length() != 0 &&
                        textFieldFirstName.getValue().toString().length() != 0 &&
                        textFieldEmail.getValue().toString().length() != 0 &&
                        textFieldPassword.getValue().toString().length()!= 0) {
                    return true;
                }
                else
                    return false;
            }
            else
                return false;
        }
        else
            return false;
    }

    private void SendEmail(){
        EmailInfo emailInfo = new EmailInfo(
                textFieldEmail.getValue().toString(),//Recipient
                "Код потверждения",//Subject
                null,//От кого
                "com/company/daex/email/registration.txt", // body template core/
                Collections.singletonMap("Code", Code) // template parameters
                );

        emailService.sendEmailAsync(emailInfo);
    }

    public String getLogin(){
    return textFieldEmail.getValue().toString();
    }

    public String getPassword(){
        return textFieldPassword.getValue().toString();
    }
}