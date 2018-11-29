package com.company.daex.entity;

import javax.persistence.*;

import com.haulmont.chile.core.annotations.Composition;
import com.haulmont.chile.core.annotations.NumberFormat;
import java.util.Date;
import java.util.List;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s|subjectName")
@Table(name = "DAEX_EXPERTISE")
@Entity(name = "daex$Expertise")
public class Expertise extends StandardEntity {
    private static final long serialVersionUID = 3721554263317303616L;

    @NotNull
    @Column(name = "EX_NUMBER", nullable = false, length = 50)
    protected String exNumber;

    @Column(name = "EGRZ_NUMBER", length = 100)
    protected String egrzNumber;

    @NotNull
    @Column(name = "IS_ARCHIVE", nullable = false)
    protected Boolean isArchive = false;

    @NotNull
    @Column(name = "IS_COMPLETED", nullable = false)
    protected Boolean isCompleted = false;

    @NotNull
    @Column(name = "PRESSMARK", nullable = false, length = 100)
    protected String pressmark;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @NotNull
    @JoinColumn(name = "LEADER_EMPLOYEE_ID")
    protected Employee leaderEmployee;

    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @NotNull
    @JoinColumn(name = "CUSTOMER_MAIN_ID")
    protected Customer customerMain;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "CUSTOMER_TECH_ID")
    protected Customer customerTech;

    @NotNull
    @Column(name = "AGREEMENT_NUMBER", nullable = false, length = 50)
    protected String agreementNumber;

    @Temporal(TemporalType.DATE)
    @NotNull
    @Column(name = "AGREEMENT_DATE", nullable = false)
    protected Date agreementDate;

    @Column(name = "COST")
    protected Double cost;

    @NotNull
    @Column(name = "SUBJECT_NAME", nullable = false, length = 200)
    protected String subjectName;

    @NotNull
    @Column(name = "SUBJECT_ADDRESS", nullable = false, length = 200)
    protected String subjectAddress;

    @NotNull
    @Column(name = "GPZU", nullable = false, length = 100)
    protected String gpzu;

    @Composition
    @OneToMany(mappedBy = "expertiseAccessSettings")
    protected List<AccessSettings> accsessSettings;

    @Composition
    @OneToMany(mappedBy = "expertiseRPD")//, cascade = CascadeType.PERSIST
    protected List<RPD> rpd;

    @JoinTable(name = "DAEX_EXPERTISE_FILE_DESCRIPTOR_LINK",
        joinColumns = @JoinColumn(name = "EXPERTISE_ID"),
        inverseJoinColumns = @JoinColumn(name = "FILE_DESCRIPTOR_ID"))
    @ManyToMany
    protected List<FileDescriptor> files;

    public void setSubjectAddress(String subjectAddress) {
        this.subjectAddress = subjectAddress;
    }

    public String getSubjectAddress() {
        return subjectAddress;
    }


    public void setEgrzNumber(String egrzNumber) {
        this.egrzNumber = egrzNumber;
    }

    public String getEgrzNumber() {
        return egrzNumber;
    }

    public void setIsArchive(Boolean isArchive) {
        this.isArchive = isArchive;
    }

    public Boolean getIsArchive() {
        return isArchive;
    }

    public void setIsCompleted(Boolean isCompleted) {
        this.isCompleted = isCompleted;
    }

    public Boolean getIsCompleted() {
        return isCompleted;
    }


    public void setFiles(List<FileDescriptor> files) {
        this.files = files;
    }

    public List<FileDescriptor> getFiles() {
        return files;
    }


    public void setExNumber(String exNumber) {
        this.exNumber = exNumber;
    }

    public String getExNumber() {
        return exNumber;
    }

    public void setPressmark(String pressmark) {
        this.pressmark = pressmark;
    }

    public String getPressmark() {
        return pressmark;
    }

    public void setLeaderEmployee(Employee leaderEmployee) {
        this.leaderEmployee = leaderEmployee;
    }

    public Employee getLeaderEmployee() {
        return leaderEmployee;
    }

    public void setCustomerMain(Customer customerMain) {
        this.customerMain = customerMain;
    }

    public Customer getCustomerMain() {
        return customerMain;
    }

    public void setCustomerTech(Customer customerTech) {
        this.customerTech = customerTech;
    }

    public Customer getCustomerTech() {
        return customerTech;
    }

    public void setAgreementNumber(String agreementNumber) {
        this.agreementNumber = agreementNumber;
    }

    public String getAgreementNumber() {
        return agreementNumber;
    }

    public void setAgreementDate(Date agreementDate) {
        this.agreementDate = agreementDate;
    }

    public Date getAgreementDate() {
        return agreementDate;
    }

    public void setCost(Double cost) {
        this.cost = cost;
    }

    public Double getCost() {
        return cost;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setGpzu(String gpzu) {
        this.gpzu = gpzu;
    }

    public String getGpzu() {
        return gpzu;
    }

    public void setAccsessSettings(List<AccessSettings> accsessSettings) {
        this.accsessSettings = accsessSettings;
    }

    public List<AccessSettings> getAccsessSettings() {
        return accsessSettings;
    }

    public void setRpd(List<RPD> rpd) {
        this.rpd = rpd;
    }

    public List<RPD> getRpd() {
        return rpd;
    }


}