package com.company.daex.service;

import com.haulmont.cuba.core.app.EmailService;
import com.haulmont.cuba.core.global.*;
import com.haulmont.cuba.security.entity.User;
import com.haulmont.cuba.security.entity.Group;
import com.haulmont.cuba.security.entity.Role;
import com.haulmont.cuba.security.entity.UserRole;
import org.springframework.stereotype.Service;

import javax.inject.Inject;
import java.util.Collections;
import java.util.UUID;

@Service(RegistrationService.NAME)
public class RegistrationServiceBean implements RegistrationService {

    /**
     * ID of the Group for self-registered users.
     */
    private static final String CUSTOMER_GROUP_ID = "342277a3-7688-93d0-be0a-26f490cdcb18";

    /**
     * ID of the Role to be assigned to self-registered users.
     */
    private static final String CUSTOMER_ROLE_ID = "4c82f733-9d20-b11d-0078-f8e68638948f";

    @Inject
    private DataManager dataManager;

    @Inject
    private EmailService emailService;

    @Inject
    private Metadata metadata;

    @Inject
    private PasswordEncryption passwordEncryption;

    //Проверка на существующего!
    public void RegistrationUser(String SecondName, String FirstName, String Email, String Password) {

        //String ss = "!";
        // Load group and role to be assigned to the new user
        Group group = dataManager.load(LoadContext.create(Group.class).setId(UUID.fromString(CUSTOMER_GROUP_ID)));
        Role role = dataManager.load(LoadContext.create(Role.class).setId(UUID.fromString(CUSTOMER_ROLE_ID)));

        // Create a user instance
        User user = metadata.create(User.class);
        user.setLogin(Email);
        user.setEmail(Email);
        user.setFirstName(SecondName);
        user.setMiddleName(FirstName);
        user.setPassword(passwordEncryption.getPasswordHash(user.getId(), Password));

        // Note that the platform does not support the default group out of the box, so here we define the default group id and set it for the newly registered users.
        user.setGroup(group);

        /* Create a link to the role
         * Here we programmatically set the default role.
         * Another way is to set the default role by using the DB scripts. Set IS_DEFAULT_ROLE parameter to true in the insert script for the role.
         * Also, this parameter might be changed in the Role Editor screen.
         */
        UserRole userRole = metadata.create(UserRole.class);
        userRole.setUser(user);
        userRole.setRole(role);

        // Save new entities
        dataManager.commit(new CommitContext(user, userRole));
    }

    public boolean CheckUser(String login){
        LoadContext<User> LContext = LoadContext.create(User.class);
        LContext.setView(View.MINIMAL);
        LContext.setQueryString("select u from sec$User u where u.loginLowerCase = :login and (u.active = true or u.active is null)")
                .setParameter("login", login.toLowerCase());

        User targetUser = dataManager.load(LContext);
        if (targetUser == null)
        {
            return true;
        }
        else
            return false;
    }

    public void SendEmail(String email, Integer code){
        EmailInfo emailInfo = new EmailInfo(
                email,//Recipient
                "Код потверждения",//Subject
                null,//От кого
                "com/company/daex/email/registration.txt", // body template core/
                Collections.singletonMap("Code", code) // template parameters
        );

        emailService.sendEmailAsync(emailInfo);
    }

}