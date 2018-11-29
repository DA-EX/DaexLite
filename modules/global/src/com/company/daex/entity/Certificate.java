package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s %s|number,workingDerction")
@Table(name = "DAEX_CERTIFICATE")
@Entity(name = "daex$Certificate")
public class Certificate extends StandardEntity {
    private static final long serialVersionUID = -3050133520963616275L;

    @NotNull
    @Column(name = "NUMBER_", nullable = false, unique = true, length = 50)
    protected String number;

    @NotNull
    @Column(name = "WORKING_DERCTION", nullable = false, length = 250)
    protected String workingDerction;

    @Temporal(TemporalType.DATE)
    @NotNull
    @Column(name = "DELIVERY", nullable = false)
    protected Date delivery;

    @Temporal(TemporalType.DATE)
    @NotNull
    @Column(name = "ENDING", nullable = false)
    protected Date ending;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "EMPLOYEE_ID")
    protected Employee employee;

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }


    public void setEmployee(Employee employee) {
        this.employee = employee;
    }

    public Employee getEmployee() {
        return employee;
    }


    public void setWorkingDerction(String workingDerction) {
        this.workingDerction = workingDerction;
    }

    public String getWorkingDerction() {
        return workingDerction;
    }

    public void setDelivery(Date delivery) {
        this.delivery = delivery;
    }

    public Date getDelivery() {
        return delivery;
    }

    public void setEnding(Date ending) {
        this.ending = ending;
    }

    public Date getEnding() {
        return ending;
    }


}