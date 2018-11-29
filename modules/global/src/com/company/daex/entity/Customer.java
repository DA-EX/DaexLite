package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.Lob;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s %s|inn,name")
@Table(name = "DAEX_CUSTOMER")
@Entity(name = "daex$Customer")
public class Customer extends StandardEntity {
    private static final long serialVersionUID = -5021592386317972335L;

    @Column(name = "NAME", length = 500)
    protected String name;

    @Lob
    @Column(name = "FULL_NAME")
    protected String fullName;

    @NotNull
    @Column(name = "INN", nullable = false, length = 12)
    protected String inn;

    @Column(name = "KPP", length = 9)
    protected String kpp;

    @Column(name = "EMAIL", length = 100)
    protected String email;

    @Column(name = "DD_BOX", length = 300)
    protected String ddBox;



    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getFullName() {
        return fullName;
    }

    public void setInn(String inn) {
        this.inn = inn;
    }

    public String getInn() {
        return inn;
    }

    public void setKpp(String kpp) {
        this.kpp = kpp;
    }

    public String getKpp() {
        return kpp;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getEmail() {
        return email;
    }

    public void setDdBox(String ddBox) {
        this.ddBox = ddBox;
    }

    public String getDdBox() {
        return ddBox;
    }


}