package com.company.daex.web.accesssettings;

import com.haulmont.cuba.core.global.DataManager;
import com.haulmont.cuba.core.global.LoadContext;
import com.haulmont.cuba.core.global.View;
import com.haulmont.cuba.gui.components.*;
import com.company.daex.entity.AccessSettings;
import com.haulmont.cuba.security.entity.User;

import javax.inject.Inject;
import java.util.Map;
import java.util.UUID;

public class AccessSettingsEdit extends AbstractEditor<AccessSettings> {

    @Inject
    private DataManager dataManager;


    //Items
    @Inject
    private CheckBox checkBoxCustomer;
    @Inject
    private CheckBox checkBoxEmployee;

    @Inject
    private Label labelCustomer;
    @Inject
    private Label labelEmployee;
    @Inject
    private LookupPickerField lookupPickerFieldCustomer;
    @Inject
    private PickerField pickerFieldEmployee;

    @Override
    public void init(Map<String, Object> params) {

        checkBoxCustomer.setValue(true);
        labelEmployee.setVisible(false);
        pickerFieldEmployee.setVisible(false);

        checkBoxCustomer.addValueChangeListener(event->{
            if(checkBoxCustomer.getValue())
            {
                checkBoxEmployee.setValue(false);
                labelCustomer.setVisible(true);
                lookupPickerFieldCustomer.setVisible(true);
                labelEmployee.setVisible(false);
                pickerFieldEmployee.setVisible(false);
            }
        });

        checkBoxEmployee.addValueChangeListener(event->{
            if(checkBoxEmployee.getValue())
            {
                checkBoxCustomer.setValue(false);
                labelEmployee.setVisible(true);
                pickerFieldEmployee.setVisible(true);
                labelCustomer.setVisible(false);
                lookupPickerFieldCustomer.setVisible(false);
            }
        });


        this.addCloseWithCommitListener(()->{

            if(CheckUser() && getItem().getEmployee().getUser_sys() != null)
            {
                getItem().setUser(LoadUser(getItem().getEmployee().getUser_sys().getUuid()));
                this.commit();//Возвращать на Экспертизу
            }

        });
    }

    private boolean CheckUser(){

        if(getItem().getUser() == null)
        {
            return true;
        }
        else
        {
            return false;
        }
    }

    private User LoadUser(UUID uuid){

        LoadContext<User> LContext = LoadContext.create(User.class);
        LContext.setView(View.MINIMAL);
        LContext.setQueryString("select u from sec$User u where u.id = :id")
                .setParameter("id", uuid);

        User targetUser = dataManager.load(LContext);

        if (targetUser == null)
        {
            return null;
        }
        else
            return targetUser;
    }
}