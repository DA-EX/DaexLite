package com.company.daex.entity;

import javax.persistence.*;

import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.chile.core.annotations.Composition;
import java.util.List;
import javax.validation.constraints.NotNull;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s|pressmark")
@Table(name = "DAEX_RPD")
@Entity(name = "daex$RPD")
public class RPD extends StandardEntity {
    private static final long serialVersionUID = -1474480621745953040L;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "HEAD_RPD_ID")
    protected HeadRPD headRPD;

    @NotNull
    @Column(name = "TOM", nullable = false)
    protected Integer tom;

    @Column(name = "PRESSMARK", length = 100)
    protected String pressmark;

    @Composition
    @OneToMany(mappedBy = "rpd")//, cascade = CascadeType.PERSIST
    protected List<RPDFile> prdFiles;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "EXPERTISE_RPD_ID")
    protected Expertise expertiseRPD;

    public void setExpertiseRPD(Expertise expertiseRPD) {
        this.expertiseRPD = expertiseRPD;
    }

    public Expertise getExpertiseRPD() {
        return expertiseRPD;
    }


    public void setTom(Integer tom) {
        this.tom = tom;
    }

    public Integer getTom() {
        return tom;
    }

    public void setPressmark(String pressmark) {
        this.pressmark = pressmark;
    }

    public String getPressmark() {
        return pressmark;
    }

    public void setPrdFiles(List<RPDFile> prdFiles) {
        this.prdFiles = prdFiles;
    }

    public List<RPDFile> getPrdFiles() {
        return prdFiles;
    }


    public void setHeadRPD(HeadRPD headRPD) {
        this.headRPD = headRPD;
    }

    public HeadRPD getHeadRPD() {
        return headRPD;
    }


}