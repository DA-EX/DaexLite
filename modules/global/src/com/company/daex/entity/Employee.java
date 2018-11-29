package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.chile.core.annotations.Composition;
import com.haulmont.cuba.core.entity.annotation.OnDelete;
import com.haulmont.cuba.core.entity.annotation.OnDeleteInverse;
import com.haulmont.cuba.core.global.DeletePolicy;
import java.util.List;
import javax.persistence.OneToMany;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import com.haulmont.chile.core.annotations.NamePattern;
import com.haulmont.cuba.security.entity.User;
import javax.persistence.JoinColumn;

@NamePattern("%s %s|firstName,midleName")
@Table(name = "DAEX_EMPLOYEE")
@Entity(name = "daex$Employee")
public class Employee extends StandardEntity {
    private static final long serialVersionUID = 8799922470870938172L;

    @NotNull
    @Column(name = "FIRST_NAME", nullable = false, length = 50)
    protected String firstName;

    @Column(name = "MIDLE_NAME", length = 50)
    protected String midleName;

    @Column(name = "LAST_NAME", length = 50)
    protected String lastName;

    @Column(name = "POSITION_", length = 300)
    protected String position;

    @NotNull
    @OneToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "USER_SYS_ID")
    protected User user_sys;

    @Composition
    @OnDeleteInverse(DeletePolicy.CASCADE)
    @OnDelete(DeletePolicy.CASCADE)
    @OneToMany(mappedBy = "employee")
    protected List<Certificate> certificate;


    public void setUser_sys(User user_sys) {
        this.user_sys = user_sys;
    }

    public User getUser_sys() {
        return user_sys;
    }



    public void setPosition(String position) {
        this.position = position;
    }

    public String getPosition() {
        return position;
    }


    public void setCertificate(List<Certificate> certificate) {
        this.certificate = certificate;
    }

    public List<Certificate> getCertificate() {
        return certificate;
    }


    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setMidleName(String midleName) {
        this.midleName = midleName;
    }

    public String getMidleName() {
        return midleName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }

    public String getLastName() {
        return lastName;
    }


}