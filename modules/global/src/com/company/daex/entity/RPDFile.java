package com.company.daex.entity;

import javax.persistence.*;

import com.haulmont.chile.core.annotations.Composition;
import java.util.Date;
import java.util.List;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.cuba.core.entity.FileDescriptor;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s|incomedate")
@Table(name = "DAEX_RPD_FILE")
@Entity(name = "daex$RPDFile")
public class RPDFile extends StandardEntity {
    private static final long serialVersionUID = 7194759685195645767L;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "INCOMEDATE")
    protected Date incomedate;

    @NotNull
    @Column(name = "IS_FINAL", nullable = false)
    protected Boolean isFinal = false;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "BEGINNINGDATE")
    protected Date beginningdate;

    @Temporal(TemporalType.TIMESTAMP)
    @Column(name = "ENDINGDATE")
    protected Date endingdate;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "RPD_ID")
    protected RPD rpd;

    @Composition
    @OneToMany(mappedBy = "rpdFile")
    protected List<RemarkAnswer> remarkAnswer;

    @JoinTable(name = "DAEX_RPD_FILE_FILE_DESCRIPTOR_LINK",
        joinColumns = @JoinColumn(name = "R_P_D_FILE_ID"),
        inverseJoinColumns = @JoinColumn(name = "FILE_DESCRIPTOR_ID"))
    @ManyToMany
    protected List<FileDescriptor> files;

    public void setIsFinal(Boolean isFinal) {
        this.isFinal = isFinal;
    }

    public Boolean getIsFinal() {
        return isFinal;
    }


    public void setFiles(List<FileDescriptor> files) {
        this.files = files;
    }

    public List<FileDescriptor> getFiles() {
        return files;
    }


    public void setRpd(RPD rpd) {
        this.rpd = rpd;
    }

    public RPD getRpd() {
        return rpd;
    }


    public void setBeginningdate(Date beginningdate) {
        this.beginningdate = beginningdate;
    }

    public Date getBeginningdate() {
        return beginningdate;
    }

    public void setEndingdate(Date endingdate) {
        this.endingdate = endingdate;
    }

    public Date getEndingdate() {
        return endingdate;
    }

    public void setIncomedate(Date incomedate) {
        this.incomedate = incomedate;
    }

    public Date getIncomedate() {
        return incomedate;
    }

    public void setRemarkAnswer(List<RemarkAnswer> remarkAnswer) {
        this.remarkAnswer = remarkAnswer;
    }

    public List<RemarkAnswer> getRemarkAnswer() {
        return remarkAnswer;
    }


}