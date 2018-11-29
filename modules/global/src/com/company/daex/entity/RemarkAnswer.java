package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import javax.persistence.Column;
import javax.persistence.Lob;
import javax.validation.constraints.NotNull;
import com.haulmont.cuba.core.entity.StandardEntity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import com.haulmont.chile.core.annotations.NamePattern;
import com.haulmont.cuba.core.entity.FileDescriptor;
import java.util.List;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;

@NamePattern("%s|remark")
@Table(name = "DAEX_REMARK_ANSWER")
@Entity(name = "daex$RemarkAnswer")
public class RemarkAnswer extends StandardEntity {
    private static final long serialVersionUID = -8658928032212735385L;

    @NotNull
    @Lob
    @Column(name = "REMARK", nullable = false)
    protected String remark;

    @Lob
    @Column(name = "ANSWER")
    protected String answer;

    @NotNull
    @Column(name = "IS_FIXED", nullable = false)
    protected Boolean isFixed = false;

    @Column(name = "AUTHOR", length = 100)
    protected String author;

    @NotNull
    @ManyToOne(fetch = FetchType.LAZY, optional = false)
    @JoinColumn(name = "RPD_FILE_ID")
    protected RPDFile rpdFile;

    @JoinTable(name = "DAEX_REMARK_ANSWER_FILE_DESCRIPTOR_LINK",
        joinColumns = @JoinColumn(name = "REMARK_ANSWER_ID"),
        inverseJoinColumns = @JoinColumn(name = "FILE_DESCRIPTOR_ID"))
    @ManyToMany
    protected List<FileDescriptor> filesRemarkAnswer;

    public void setFilesRemarkAnswer(List<FileDescriptor> filesRemarkAnswer) {
        this.filesRemarkAnswer = filesRemarkAnswer;
    }

    public List<FileDescriptor> getFilesRemarkAnswer() {
        return filesRemarkAnswer;
    }


    public void setIsFixed(Boolean isFixed) {
        this.isFixed = isFixed;
    }

    public Boolean getIsFixed() {
        return isFixed;
    }


    public void setAuthor(String author) {
        this.author = author;
    }

    public String getAuthor() {
        return author;
    }


    public void setRpdFile(RPDFile rpdFile) {
        this.rpdFile = rpdFile;
    }

    public RPDFile getRpdFile() {
        return rpdFile;
    }


    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getRemark() {
        return remark;
    }

    public void setAnswer(String answer) {
        this.answer = answer;
    }

    public String getAnswer() {
        return answer;
    }


}