package com.company.daex.entity;

import javax.persistence.Entity;
import javax.persistence.Table;
import com.haulmont.cuba.core.entity.FileDescriptor;
import java.util.List;
import javax.persistence.Column;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.Lob;
import javax.persistence.ManyToMany;
import com.haulmont.cuba.core.entity.StandardEntity;
import com.haulmont.chile.core.annotations.NamePattern;

@NamePattern("%s|createTs")
@Table(name = "DAEX_INCOMING_DOCUMENT")
@Entity(name = "daex$IncomingDocument")
public class IncomingDocument extends StandardEntity {
    private static final long serialVersionUID = 6014016637115865847L;

    @Lob
    @Column(name = "DESCRIPTION")
    protected String description;

    @JoinTable(name = "DAEX_INCOMING_DOCUMENT_FILE_DESCRIPTOR_LINK",
        joinColumns = @JoinColumn(name = "INCOMING_DOCUMENT_ID"),
        inverseJoinColumns = @JoinColumn(name = "FILE_DESCRIPTOR_ID"))
    @ManyToMany
    protected List<FileDescriptor> files;

    public void setDescription(String description) {
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public void setFiles(List<FileDescriptor> files) {
        this.files = files;
    }

    public List<FileDescriptor> getFiles() {
        return files;
    }


}