package com.company.daex.web.registrationScreens;

import com.haulmont.cuba.gui.WindowManager;
import com.haulmont.cuba.gui.components.Button;
import com.haulmont.cuba.web.app.loginwindow.AppLoginWindow;

import javax.inject.Inject;

public class ExtAppLoginWindow extends AppLoginWindow {

    @Inject
    private Button loginButton;

    public void onRegistrationBtnClick()
    {
        // Open "Register" screen in dialog mode
        // Открыть экран "Регистрации" в качестве диалога
        Registration Screen = (Registration) openWindow("registration", WindowManager.OpenType.DIALOG);
        // Add a listener to be notified when the "Register" screen is closed with COMMIT_ACTION_ID
        // Добавить листенер, который сработает когда окно регистрации будет закрыто
        Screen.addCloseWithCommitListener(() ->
        {
            // Set the new registered user credentials to login and password fields
            // Установить новые регистрационные учетные данные пользователя дя полей входа и пароля
            loginField.setValue(Screen.getLogin());
            passwordField.setValue(Screen.getPassword());

            // Set focus on "Submit" button
            // Установить фокус на кнопку отправить
            loginButton.requestFocus();
        });
    }
}