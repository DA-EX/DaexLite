package com.company.daex.listener;

import org.springframework.stereotype.Component;
import com.haulmont.cuba.core.listener.BeforeDetachEntityListener;
import com.haulmont.cuba.core.EntityManager;
import com.haulmont.cuba.security.entity.User;

@Component("daex_UserLIstener")
public class UserLIstener implements BeforeDetachEntityListener<User> {


    @Override
    public void onBeforeDetach(User entity, EntityManager entityManager) {


/*
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
        });*/
    }


}