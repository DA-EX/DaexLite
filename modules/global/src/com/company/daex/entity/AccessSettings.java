package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.cuba.security.entity.User;
import javax.persistence.Column;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import com.haulmont.cuba.core.entity.StandardEntity;
import javax.persistence.ManyToOne;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s %s|user,isRead")
@Table(name = "DAEX_ACCESS_SETTINGS")
@Entity(name = "daex$AccessSettings")
public class AccessSettings extends StandardEntity {
    private static final long serialVersionUID = 2480038162886195807L;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "USER_ID")
    protected User user;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "EMPLOYEE_ID")
    protected Employee employee;

    @Column(name = "IS_READ")
    protected Boolean isRead;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "EXPERTISE_ACCESS_SETTINGS_ID")
    protected Expertise expertiseAccessSettings;

    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Employee getEmployee() {
        return employee;
    }


    public void setExpertiseAccessSettings(Expertise expertiseAccessSettings) {
        this.expertiseAccessSettings = expertiseAccessSettings;
    }

    public Expertise getExpertiseAccessSettings() {
        return expertiseAccessSettings;
    }


    public void setUser(User user) {
        this.user = user;
    }

    public User getUser() {
        return user;
    }

    public void setIsRead(Boolean isRead) {
        this.isRead = isRead;
    }

    public Boolean getIsRead() {
        return isRead;
    }


}