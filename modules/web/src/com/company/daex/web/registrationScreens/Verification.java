package com.company.daex.web.registrationScreens;

import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.core.global.View;
import com.haulmont.cuba.gui.WindowManager;
import com.haulmont.cuba.gui.WindowParam;
import com.haulmont.cuba.gui.components.AbstractWindow;
import com.haulmont.cuba.gui.components.TextField;
import com.company.daex.service.RegistrationService;
import com.haulmont.cuba.security.app.UserManagementService;
import com.haulmont.cuba.security.entity.User;

import javax.inject.Inject;

import static com.haulmont.cuba.gui.components.Window.Editor.WINDOW_CLOSE;

public class Verification extends AbstractWindow {

    @WindowParam
    private String SecondName;

    @WindowParam
    private String FirstName;

    @WindowParam
    private String Email;

    @WindowParam
    private Integer Code;

    @WindowParam
    private String Password;

    @Inject
    private TextField textFieldVerificationCode;

    @Inject
    private RegistrationService registrationService;

    public void onSubmitBtnClick(){

            if (this.CheckField() != false) {
                String code= textFieldVerificationCode.getValue().toString().replace("\\s+","");
                code= textFieldVerificationCode.getValue().toString().replace(" ", "");

                if (Code.toString().equals(code) == true ) {
                        registrationService.RegistrationUser(SecondName, FirstName, Email, Password);
                        //showNotification("Успешно", NotificationType.TRAY);
                        super.close(WINDOW_CLOSE);
/*
                    showNotification("Проверка " + SecondName + " /"
                                    + FirstName + " /"
                                    + Email + " /"
                                    + " /" + Code,
                            NotificationType.HUMANIZED);*/
                    showNotification("Регистрация завершена! Используйте пару логин, пароль для авторизации", NotificationType.HUMANIZED);


                } else {
                    showNotification("Неверный код подтверждения! ", NotificationType.ERROR_HTML);
                }
            } else {
                showNotification("Введите код!", NotificationType.WARNING_HTML);
            }
    }

    private boolean CheckField(){

        if(textFieldVerificationCode != null)
        {
            if(     textFieldVerificationCode.getValue() != null ){
                if(     textFieldVerificationCode.getValue().toString().length() != 0 ) {
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

}