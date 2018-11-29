package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import javax.persistence.FetchType;
import javax.persistence.OneToOne;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s|pressmark")
@Table(name = "DAEX_HEAD_RPD")
@Entity(name = "daex$HeadRPD")
public class HeadRPD extends StandardEntity {
    private static final long serialVersionUID = 5364046548795815617L;

    @NotNull
    @Column(name = "PRESSMARK", nullable = false, length = 50)
    protected String pressmark;

    @Column(name = "NAME")
    protected String name;


    public void setPressmark(String pressmark) {
        this.pressmark = pressmark;
    }

    public String getPressmark() {
        return pressmark;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getName() {
        return name;
    }


}